package com.zhimu.service.manager.cms;

import javax.annotation.Resource;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.zhimu.dao.DaoSupport;
import com.zhimu.dao.entity.cms.Config;

@Service("configService")
public class ConfigService {
	@Resource(name = "daoSupport")
	private DaoSupport configDao;
	
	/**
	 * 增加配置
	 * @param key
	 * @param value
	 * @return
	 */
	/*public Config addConfig(String key,String value){
		Config config = new Config();
		config.setKey(key);
		config.setValue(value);
		config.setCreateTime(new Date());
		configDao.addConfig(config);
		return config;
		
	}*/
	/**
	 * 删除配置
	 * @param key
	 * @return
	 */
	/*@CacheEvict(value="config")
	public int deleteConfigByKey(String key){
		return configDao.deleteConfig(key);
	}*/
	
	/**
	 * 更新配置
	 * @param key
	 * @param value
	 * @return
	 * @throws Exception 
	 */
	@CacheEvict(value="config",allEntries=true)
	public Config updateConfigByKey(String key,String value) throws Exception{
		//
		Config config =	(Config) configDao.findForObject("ConfigMapper.getConfigByKey", key);
		//Config config = configDao.getConfigByKey(key);
		config.setValue(value);
		configDao.update("ConfigMapper.updateConfig", config);
	//	configDao.updateConfig(config);
		this.getStringByKey(key);
		return config;
	}
	/**
	 * 获取配置
	 * @param key
	 * @return
	 * @throws Exception 
	 */
	@Cacheable(value="config")
	public String getStringByKey(String key) throws Exception{
		Config config =	(Config) configDao.findForObject("ConfigMapper.getConfigByKey", key);
		//Config config = configDao.getConfigByKey(key);
		if(config==null){
			return "";
		}else{
			return config.getValue();
		}
	}
	/**
	 * 获取配置，并将字符串数字转换成整数
	 * @param key
	 * @return
	 * @throws Exception 
	 */
	@Cacheable(value="config")
	public String getIntKey(String key) throws Exception{
		Config config =	(Config) configDao.findForObject("ConfigMapper.getConfigByKey", key);
		//Config config = configDao.getConfigByKey(key);
		if(config == null){
			return "";
		}else{
			return config.getValue();
		}
	}
	/**
	 * 获取网站所有配置
	 * @return
	 */
	/*public List<Config>  getAllConfig(){
		return configDao.getAllConfig();
	}*/
}
