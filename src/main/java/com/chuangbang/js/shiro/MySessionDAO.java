package com.chuangbang.js.shiro;

import java.io.Serializable;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.shiro.session.Session;
import org.apache.shiro.session.UnknownSessionException;

public class MySessionDAO{
	private static Map<Serializable,Session> map = new HashMap<Serializable,Session>();
	public static void update(Session session) throws UnknownSessionException {
		map.put(session.getId(),session);
	}

	public static void delete(Session session) {
	    map.remove(session.getId());
	}

	public static Collection<Session> getActiveSessions() {
	    return map.values();
	}

	public static Serializable doCreate(Session session) {
		map.put(session.getId(), session);

		return session.getId();
	}

	public static Session doReadSession(Serializable sessionId) {
		return map.get(sessionId);
	}
	
	public static void clean(){
		Iterator<Entry<Serializable,Session>> entryKeyIterator = map.entrySet().iterator();  
        while (entryKeyIterator.hasNext()) { 
        	try{
        		Entry<Serializable,Session> e = entryKeyIterator.next();  
        		Session session = e.getValue();
        		map.remove(session.getId());
            }catch(Exception e){
            	e.printStackTrace();
            }
        } 
	}

}
