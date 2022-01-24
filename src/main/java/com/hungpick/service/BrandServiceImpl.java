package com.hungpick.service;

import java.util.List;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hungpick.dao.IBrandDao;
import com.hungpick.dto.BrandDto;

@Service("brandService")
public class BrandServiceImpl implements IBrandService {
	
	@Autowired
	private IBrandDao brandDao;
	
	private static final Logger logger = LoggerFactory.getLogger(BrandServiceImpl.class);
	
	
	@Override
	public List<BrandDto> sltMulti() {
		logger.info("Brand sltMulti called =========");
		
		return brandDao.sltMulti();
	}

}
