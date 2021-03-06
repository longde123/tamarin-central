/* ***** BEGIN LICENSE BLOCK *****
* Version: MPL 1.1/GPL 2.0/LGPL 2.1
*
* The contents of this file are subject to the Mozilla Public License Version
* 1.1 (the "License"); you may not use this file except in compliance with
* the License. You may obtain a copy of the License at
* http://www.mozilla.org/MPL/
*
* Software distributed under the License is distributed on an "AS IS" basis,
* WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
* for the specific language governing rights and limitations under the
* License.
*
* The Original Code is [Open Source Virtual Machine.].
*
* The Initial Developer of the Original Code is
* Adobe System Incorporated.
* Portions created by the Initial Developer are Copyright (C) 2009
* the Initial Developer. All Rights Reserved.
*
* Contributor(s):
*   Adobe AS3 Team
*
* Alternatively, the contents of this file may be used under the terms of
* either the GNU General Public License Version 2 or later (the "GPL"), or
* the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
* in which case the provisions of the GPL or the LGPL are applicable instead
* of those above. If you wish to allow use of your version of this file only
* under the terms of either the GPL or the LGPL, and not to allow others to
* use your version of this file under the terms of the MPL, indicate your
* decision by deleting the provisions above and replace them with the notice
* and other provisions required by the GPL or the LGPL. If you do not delete
* the provisions above, a recipient may use your version of this file under
* the terms of any one of the MPL, the GPL or the LGPL.
*
* ***** END LICENSE BLOCK ***** */

// regression test for bug https://bugzilla.mozilla.org/show_bug.cgi?id=496633

package {
    import avmplus.Domain
    import flash.utils.ByteArray


    var domain1:Domain=new Domain(Domain.currentDomain);
    var domain2:Domain=new Domain(Domain.currentDomain);

    var bytecode1:Array=[16, 0, 46, 0, 0, 0, 0, 16, 3, 102, 111, 111, 0, 6, 102, 111, 111, 46, 97, 115, 7, 102, 111, 111, 47, 102, 111, 111, 6, 79, 98, 106, 101, 99, 116, 4, 109, 111, 100, 49, 7, 109, 111, 100, 49, 46, 97, 115, 1, 118, 6, 86, 101, 99, 116, 111, 114, 9, 109, 111, 100, 49, 46, 97, 115, 36, 49, 11, 95, 95, 65, 83, 51, 95, 95, 46, 118, 101, 99, 4, 112, 117, 115, 104, 5, 112, 114, 105, 110, 116, 16, 99, 111, 110, 115, 116, 114, 117, 99, 116, 101, 100, 32, 109, 111, 100, 49, 9, 109, 111, 100, 49, 47, 109, 111, 100, 49, 11, 5, 1, 22, 2, 24, 1, 5, 6, 5, 10, 23, 2, 24, 6, 26, 6, 26, 5, 22, 11, 4, 8, 2, 4, 5, 6, 7, 8, 9, 10, 7, 2, 4, 5, 6, 7, 8, 9, 3, 2, 5, 6, 12, 7, 2, 1, 7, 2, 5, 9, 9, 1, 7, 10, 9, 29, 4, 1, 1, 9, 1, 2, 9, 12, 2, 9, 13, 2, 7, 2, 6, 9, 5, 3, 9, 6, 3, 5, 0, 0, 2, 0, 0, 0, 4, 0, 0, 0, 2, 0, 0, 0, 15, 0, 0, 0, 2, 0, 0, 2, 1, 2, 9, 3, 0, 1, 0, 9, 2, 9, 7, 0, 3, 0, 0, 0, 2, 0, 1, 4, 2, 1, 4, 1, 0, 9, 4, 2, 1, 5, 0, 1, 1, 3, 4, 3, 208, 48, 71, 0, 0, 1, 1, 1, 4, 5, 14, 241, 3, 240, 5, 208, 48, 240, 6, 208, 73, 0, 240, 7, 71, 0, 0, 2, 1, 1, 3, 4, 3, 208, 48, 71, 0, 0, 3, 2, 2, 4, 5, 57, 241, 7, 240, 3, 208, 48, 240, 3, 208, 73, 0, 239, 1, 8, 0, 4, 240, 4, 93, 3, 102, 3, 100, 108, 1, 83, 1, 66, 0, 128, 5, 213, 240, 5, 209, 93, 6, 74, 6, 0, 70, 7, 1, 41, 240, 8, 93, 8, 44, 14, 70, 8, 1, 41, 240, 9, 71, 0, 0, 4, 2, 2, 1, 3, 57, 208, 48, 241, 3, 240, 3, 101, 0, 93, 2, 102, 2, 48, 93, 10, 102, 10, 88, 0, 29, 104, 1, 241, 7, 240, 2, 101, 0, 93, 2, 102, 2, 48, 93, 10, 102, 10, 88, 1, 29, 104, 9, 241, 7, 240, 11, 93, 11, 74, 11, 0, 130, 213, 209, 72, 8, 1, 0, 0];
    var bytecode2:Array=[16, 0, 46, 0, 0, 0, 0, 16, 3, 102, 111, 111, 0, 6, 102, 111, 111, 46, 97, 115, 7, 102, 111, 111, 47, 102, 111, 111, 6, 79, 98, 106, 101, 99, 116, 4, 109, 111, 100, 50, 7, 109, 111, 100, 50, 46, 97, 115, 1, 118, 6, 86, 101, 99, 116, 111, 114, 9, 109, 111, 100, 50, 46, 97, 115, 36, 49, 11, 95, 95, 65, 83, 51, 95, 95, 46, 118, 101, 99, 4, 112, 117, 115, 104, 5, 112, 114, 105, 110, 116, 16, 99, 111, 110, 115, 116, 114, 117, 99, 116, 101, 100, 32, 109, 111, 100, 50, 9, 109, 111, 100, 50, 47, 109, 111, 100, 50, 11, 5, 1, 22, 2, 24, 1, 5, 6, 5, 10, 23, 2, 24, 6, 26, 6, 26, 5, 22, 11, 4, 8, 2, 4, 5, 6, 7, 8, 9, 10, 7, 2, 4, 5, 6, 7, 8, 9, 3, 2, 5, 6, 12, 7, 2, 1, 7, 2, 5, 9, 9, 1, 7, 10, 9, 29, 4, 1, 1, 9, 1, 2, 9, 12, 2, 9, 13, 2, 7, 2, 6, 9, 5, 3, 9, 6, 3, 5, 0, 0, 2, 0, 0, 0, 4, 0, 0, 0, 2, 0, 0, 0, 15, 0, 0, 0, 2, 0, 0, 2, 1, 2, 9, 3, 0, 1, 0, 9, 2, 9, 7, 0, 3, 0, 0, 0, 2, 0, 1, 4, 2, 1, 4, 1, 0, 9, 4, 2, 1, 5, 0, 1, 1, 3, 4, 3, 208, 48, 71, 0, 0, 1, 1, 1, 4, 5, 14, 241, 3, 240, 5, 208, 48, 240, 6, 208, 73, 0, 240, 7, 71, 0, 0, 2, 1, 1, 3, 4, 3, 208, 48, 71, 0, 0, 3, 2, 2, 4, 5, 57, 241, 7, 240, 3, 208, 48, 240, 3, 208, 73, 0, 239, 1, 8, 0, 4, 240, 4, 93, 3, 102, 3, 100, 108, 1, 83, 1, 66, 0, 128, 5, 213, 240, 5, 209, 93, 6, 74, 6, 0, 70, 7, 1, 41, 240, 8, 93, 8, 44, 14, 70, 8, 1, 41, 240, 9, 71, 0, 0, 4, 2, 2, 1, 3, 57, 208, 48, 241, 3, 240, 3, 101, 0, 93, 2, 102, 2, 48, 93, 10, 102, 10, 88, 0, 29, 104, 1, 241, 7, 240, 2, 101, 0, 93, 2, 102, 2, 48, 93, 10, 102, 10, 88, 1, 29, 104, 9, 241, 7, 240, 11, 93, 11, 74, 11, 0, 130, 213, 209, 72, 8, 1, 0, 0];
    
    print("regression test for bug https://bugzilla.mozilla.org/show_bug.cgi?id=496633");

    var bytearray1:ByteArray=new ByteArray();

    var i:uint;

    for (i=0;i<bytecode1.length;i++) {
        bytearray1.writeByte(bytecode1[i]);
    }
    var bytearray2:ByteArray=new ByteArray();
    for (i=0;i<bytecode2.length;i++) {
        bytearray2.writeByte(bytecode2[i]);
    }
    
    domain1.loadBytes(bytearray1);
    domain2.loadBytes(bytearray2);
    trace(domain1 == domain2);

    print("vector domain bug 496633 : PASSED!");
}
