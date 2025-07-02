package com.hcl.bss.repository.generator;

import org.hibernate.Session;
import org.hibernate.tuple.ValueGenerator;

public class LoggedUserGenerator implements ValueGenerator<String> {

    @Override
    public String generateValue(Session session, Object owner) {
        return "System";
    }

}
