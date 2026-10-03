from typing_extensions import Literal

CallOutcome = Literal['completed', 'busy', 'rejected', 'no_answer', 'failed']


def classify_call_outcome(was_established: bool, sip_status_code: int) -> CallOutcome:
    if was_established:
        return 'completed'
    if sip_status_code in (486, 600):
        return 'busy'
    if sip_status_code in (401, 403, 603):
        return 'rejected'
    if sip_status_code in (408, 480, 487):
        return 'no_answer'
    return 'failed'
