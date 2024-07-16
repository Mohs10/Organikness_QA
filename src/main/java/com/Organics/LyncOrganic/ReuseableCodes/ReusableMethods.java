package com.Organics.LyncOrganic.ReuseableCodes;

import org.springframework.stereotype.Service;



@Service
public class ReusableMethods {

    int x;

    public boolean isPartialMatch(String source, String target) {
        if (source.length() < target.length()) {
            return false;
        }

        for (int i = 0; i < target.length(); i++) {
            if (source.charAt(i) != target.charAt(i)) {
                return false;
            }
        }
        return true;
    }
}
