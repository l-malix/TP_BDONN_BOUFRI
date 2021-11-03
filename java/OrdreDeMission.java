/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.centrale.tp_bdonn;

import java.sql.*;

/**
 *
 * @author lmalix
 */
public class OrdreDeMission {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws SQLException {

        GenererOrdre ordre = new GenererOrdre("DENT", "Arthur");
        ordre.genererOrdreDeMission();
    }
}
