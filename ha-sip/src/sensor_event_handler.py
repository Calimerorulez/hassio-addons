from __future__ import annotations

from typing import Any, Dict, Optional
from datetime import datetime

from sensor import SensorUpdater


class SensorEventHandler:
    def __init__(self, sensor_updater: SensorUpdater):
        self.sensor_updater = sensor_updater
        # Track call direction per active call.
        self.call_directions: Dict[str, str] = {}
        self.active_call_ids: set[str] = set()
        self.call_history: Dict[int, list[Dict[str, Any]]] = {}

    def handle_event(self, event: Any, webhook_id: Optional[str] = None) -> None:
        event_type = event.get("event")
        sip_account = event.get("sip_account")
        if sip_account is None:
            return
        internal_id = event.get("internal_id")
        direction_key = internal_id or f"account:{sip_account}"
        if event_type == "incoming_call":
            self.call_directions[direction_key] = "incoming"
            self.sensor_updater.set_call_active(sip_account, event)
            if internal_id and internal_id not in self.active_call_ids:
                self.active_call_ids.add(internal_id)
                self.sensor_updater.set_call_count_delta(1)
        elif event_type == "outgoing_call_initiated":
            self.call_directions[direction_key] = "outgoing"
            if internal_id and internal_id not in self.active_call_ids:
                self.active_call_ids.add(internal_id)
                self.sensor_updater.set_call_count_delta(1)
        elif event_type == "call_established":
            self.sensor_updater.set_call_active(sip_account, event)
        elif event_type == "call_disconnected":
            self.sensor_updater.set_call_inactive(sip_account)
            if internal_id and internal_id in self.active_call_ids:
                self.active_call_ids.remove(internal_id)
                self.sensor_updater.set_call_count_delta(-1)
            direction = self.call_directions.pop(direction_key, event.get("call_direction", "incoming"))
            self.sensor_updater.update_last_call(sip_account, direction, event)
            history = self.call_history.setdefault(sip_account, [])
            history_entry = {
                "timestamp": datetime.now().isoformat(),
                "call_direction": direction,
                "remote_uri": event.get("remote_uri"),
                "parsed_remote_uri": event.get("parsed_remote_uri"),
                "local_uri": event.get("local_uri"),
                "parsed_local_uri": event.get("parsed_local_uri"),
                "duration_seconds": event.get("duration_seconds"),
                "sip_status_code": event.get("sip_status_code"),
                "sip_reason": event.get("sip_reason"),
                "outcome": event.get("outcome"),
            }
            history.insert(0, history_entry)
            del history[20:]
            self.sensor_updater.update_call_history(sip_account, history)
