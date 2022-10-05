package org.moqui.sftp;

import org.moqui.context.ExecutionContext;
import org.moqui.util.SystemBinding;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * @author Ian Yuan
 * @version V1.0
 * @Title: SftpOCC
 * @Package org.velox.portal.sftp
 * @Description: Copy ChoiceTrade spread file to OCC sftp directory
 * @date 9/7/22
 */
public class SftpOCC {


    /**
     * Move spread file map.
     * Copy occ file from ChoiceTrade
     * Do nothing with it
     * Paste to the remote sftp server of OCC
     *
     * @param ec the ec
     * @return the map
     */
    public static Map<String, Object> moveSpreadFile(ExecutionContext ec){

        // Get the configuration in MoquiConf.xml
        String occSftpAddress = SystemBinding.getPropOrEnv("occ_sftp_address");
        String occSftpPort = SystemBinding.getPropOrEnv("occ_sftp_port");
        String occSftpAccount = SystemBinding.getPropOrEnv("occ_sftp_account");
        String occOpenSSHKeyfile = SystemBinding.getPropOrEnv("occ_sftp_key_file");

        String veloxSftpAddress = SystemBinding.getPropOrEnv("velox_sftp_address");
        String veloxSftpPort = SystemBinding.getPropOrEnv("velox_sftp_port");
        String veloxSftpAccount = SystemBinding.getPropOrEnv("velox_sftp_account");
        String veloxSftpPassword = SystemBinding.getPropOrEnv("velox_sftp_password");

        // Sftp Util Object
        SftpClient occSftpClient;
        SftpClient veloxSftpClient;

        // Carry return result
        Map<String, Object> result = new HashMap<String, Object>();

        try {
            occSftpClient = new SftpClient(occSftpAddress, occSftpAccount, Integer.parseInt(occSftpPort)).openSSHKeyFile(occOpenSSHKeyfile).connect();
            veloxSftpClient = new SftpClient(veloxSftpAddress, veloxSftpAccount, Integer.parseInt(veloxSftpPort)).password(veloxSftpPassword).connect();




        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        result.put("Move Status", "Success");
        return result;

    }









}
