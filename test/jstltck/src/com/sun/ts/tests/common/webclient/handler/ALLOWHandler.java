/*
 * Copyright 2008 Sun Microsystems, Inc. All rights reserved.
 * SUN PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */

/*
 * $Id$
 */
package com.sun.ts.tests.common.webclient.handler;

import org.apache.commons.httpclient.Header;

import java.util.StringTokenizer;

import com.sun.ts.lib.util.TestUtil;

public class ALLOWHandler implements Handler {

    private static final Handler HANDLER = new ALLOWHandler();
    private static final String DELIM = "##";

    private ALLOWHandler() {
    }

    public static Handler getInstance() {
        return HANDLER;
    }

    public boolean invoke(Header configuredHeader, Header responseHeader) {
        String ALLOWHeader = responseHeader.getValue().toLowerCase();
        String expectedValues = configuredHeader.getValue().toLowerCase().
                replace(" ", "");

        TestUtil.logTrace("[ALLOWHandler] ALLOW header received: " +
                ALLOWHeader);

        StringTokenizer conf = new StringTokenizer(expectedValues, ",");
        while (conf.hasMoreTokens()) {
            String token = conf.nextToken();
            String token1 = token;

            if ((ALLOWHeader.indexOf(token) < 0) &&
                    (ALLOWHeader.indexOf(token1) < 0)) {
                TestUtil.logErr("[ALLOWHandler] Unable to find '" +
                        token +
                        "' within the ALLOW header returned by the server.");
                return false;
            } else {
                TestUtil.logTrace("[ALLOWHandler] Found expected value, '" +
                        token + "' in ALLOW header returned by server.");
            }
        }
        return true;
    }
}