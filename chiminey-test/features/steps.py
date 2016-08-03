from lettuce import *
from lettuce_webdriver.util import assert_true
from lettuce_webdriver.util import AssertContextManager
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from selenium.webdriver.support.ui import WebDriverWait # available since 2.4.0
from selenium.webdriver.support import expected_conditions as EC # available since 2.26.0

@step('I go to \"(.*)\"')
def go_to(step, text):
    world.driver.get(text)

@step(u'Then page title should be "([^"]*)"')
def then_page_title_should_be(step, text):
    try:
        WebDriverWait(world.driver, 120).until(EC.title_contains(text))
        assert_true(step, text in world.driver.title)
        assert_true(step, world.driver.find_element_by_id("id_username"))
        assert_true(step, world.driver.find_element_by_id("id_password"))
    finally:
        world.driver.quit()
