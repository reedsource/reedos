package top.reed.cms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.reed.cms.mapper.WebSiteMapper;
import top.reed.cms.service.IWebSiteService;

import java.util.Map;

@Service
public class WebSiteService implements IWebSiteService {
	@Autowired
	private WebSiteMapper webSiteMapper;

	@Override
	public Map getSiteInfo() {
		return webSiteMapper.getSiteInfo();
	}
}
