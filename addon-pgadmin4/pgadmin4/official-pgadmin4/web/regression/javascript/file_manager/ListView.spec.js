/////////////////////////////////////////////////////////////
//
// pgAdmin 4 - PostgreSQL Tools
//
// Copyright (C) 2013 - 2022, The pgAdmin Development Team
// This software is released under the PostgreSQL Licence
//
//////////////////////////////////////////////////////////////

import jasmineEnzyme from 'jasmine-enzyme';
import React from 'react';
import '../helper/enzyme.helper';
import { createMount } from '@material-ui/core/test-utils';
import Theme from '../../../pgadmin/static/js/Theme';
import { CustomRow, FileNameEditor, GridContextUtils } from '../../../pgadmin/misc/file_manager/static/js/components/ListView';

describe('ListView', ()=>{
  let mount;

  /* Use createMount so that material ui components gets the required context */
  /* https://material-ui.com/guides/testing/#api */
  beforeAll(()=>{
    mount = createMount();
  });

  afterAll(() => {
    mount.cleanUp();
  });

  beforeEach(()=>{
    jasmineEnzyme();
  });

  describe('FileNameEditor', ()=>{
    let row = {'Filename': 'test.sql', 'Size': '1KB'},
      column = {
        key: 'Filename'
      },
      ctrlMount = (props)=>{
        return mount(<Theme>
          <FileNameEditor
            row={row}
            column={column}
            {...props}
          />
        </Theme>);
      };

    it('init', (done)=>{
      let ctrl = ctrlMount({
        onRowChange: ()=>{/* test func */},
        onClose: ()=>{/* test func */},
      });
      setTimeout(()=>{
        ctrl.update();
        expect(ctrl.find('input').props()).toEqual(jasmine.objectContaining({value: 'test.sql'}));
        done();
      }, 0);
    });

    it('keydown Tab', (done)=>{
      let onCloseSpy = jasmine.createSpy('onClose');
      let ctrl = ctrlMount({
        onRowChange: ()=>{/* test func */},
        onClose: onCloseSpy,
      });
      setTimeout(()=>{
        ctrl.update();
        expect(ctrl.find('input').props()).toEqual(jasmine.objectContaining({value: 'test.sql'}));
        ctrl.find('input').simulate('keydown', { code: 'Tab'});
        setTimeout(()=>{
          expect(onCloseSpy).toHaveBeenCalled();
          done();
        });
      }, 0);
    });
  });

  describe('CustomRow', ()=>{
    let row = {'Filename': 'test.sql', 'Size': '1KB'},
      ctrlMount = (onItemSelect, onItemEnter)=>{
        return mount(<Theme>
          <GridContextUtils.Provider value={{onItemSelect, onItemEnter}}>
            <CustomRow
              row={row}
              selectedCellIdx={0}
              rowIdx={0}
              inTest={true}
            />
          </GridContextUtils.Provider>
        </Theme>);
      };

    it('init', (done)=>{
      let onItemSelect = jasmine.createSpy('onItemSelect');
      let onItemEnter = jasmine.createSpy('onItemEnter');
      let ctrl = ctrlMount(onItemSelect, onItemEnter);
      setTimeout(()=>{
        ctrl.update();
        ctrl.find('div[data-test="test-div"]').simulate('keydown', { code: 'Enter'});
        setTimeout(()=>{
          ctrl.update();
          expect(onItemEnter).toHaveBeenCalled();
          ctrl?.unmount();
          done();
        }, 0);
      }, 0);
    });
  });
});
