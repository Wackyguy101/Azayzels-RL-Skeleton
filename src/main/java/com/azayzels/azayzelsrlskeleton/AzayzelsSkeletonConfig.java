package com.azayzels.skeleton;

import net.runelite.client.config.Config;
import net.runelite.client.config.ConfigGroup;
import net.runelite.client.config.ConfigItem;

@ConfigGroup("azazelbase")
public interface AzayzelsSkeletonConfig extends Config
{
	@ConfigItem(
		position = 1,
		keyName = "greeting",
		name = "Greeting",
		description = "Chat message shown on login"
	)
	default String greeting()
	{
		return "hello";
	}
}
