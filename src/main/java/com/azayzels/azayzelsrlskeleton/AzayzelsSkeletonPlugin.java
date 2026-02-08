package com.azayzels.skeleton;

import com.google.inject.Provides;
import javax.inject.Inject;
import lombok.extern.slf4j.Slf4j;
import net.runelite.api.ChatMessageType;
import net.runelite.api.Client;
import net.runelite.api.GameState;
import net.runelite.api.events.GameStateChanged;
import net.runelite.client.config.ConfigManager;
import net.runelite.client.eventbus.Subscribe;
import net.runelite.client.plugins.Plugin;
import net.runelite.client.plugins.PluginDescriptor;

@Slf4j
@PluginDescriptor(
	name = "Azazel Base",
	description = "Minimal, known-good RuneLite plugin skeleton.",
	tags = {"azazel", "skeleton"}
)
public class AzayzelsSkeletonPlugin extends Plugin
{
	@Inject
	private Client client;

	@Inject
	private AzayzelsSkeletonConfig config;

	@Override
	protected void startUp()
	{
		log.info("Azazel Base started");
	}

	@Override
	protected void shutDown()
	{
		log.info("Azazel Base stopped");
	}

	@Subscribe
	public void onGameStateChanged(GameStateChanged e)
	{
		if (e.getGameState() == GameState.LOGGED_IN)
		{
			client.addChatMessage(ChatMessageType.GAMEMESSAGE, "", "[Azazel Base] " + config.greeting(), null);
		}
	}

	@Provides
	AzayzelsSkeletonConfig provideConfig(ConfigManager configManager)
	{
		return configManager.getConfig(AzayzelsSkeletonConfig.class);
	}
}
