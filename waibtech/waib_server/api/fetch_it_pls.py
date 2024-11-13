from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
import undetected_chromedriver as uc
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from datetime import datetime, UTC

def fetch_information(url):
    options = uc.ChromeOptions()
    # options.add_argument("--headless")  
    options.add_argument("--headless=new")
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-gpu")
    options.add_argument("blink-settings=imagesEnabled=false")
    options.add_argument("--disable-dev-shm-usage")
    # options.page_load_strategy = 'eager'

    driver = webdriver.Chrome(service=Service(), options=options)

    driver.get(url)



    event_name = driver.find_element(By.CSS_SELECTOR,".large-9 > h1:nth-child(1)").get_attribute("textContent")

    performance_info= driver.find_elements(By.CSS_SELECTOR, ".performance-info")
    performances = [] 
    for div in performance_info:
        dow = div.find_element(By.CSS_SELECTOR,".dow").get_attribute("textContent")
        date = div.find_element(By.CLASS_NAME,"date").get_attribute("textContent")
        time = div.find_element(By.CLASS_NAME,"time").get_attribute("textContent")
        venue = div.find_element(By.CLASS_NAME,"venue").get_attribute("textContent")
        
        date = datetime.strptime(date,"%B %d, %Y").strftime("%d/%m/%Y")
        performances.append({"date":date,"time":time,"dow":dow,'venue':venue})
        # date_time = datetime.strptime(f"{time}-{date}","%I:%M%p-%B %d, %Y")
        # performances.append({"date_time":date_time,"dow":dow,'venue':venue})


    artists_info = driver.find_elements(By.CLASS_NAME,"event-detail-artist")
    artists = []
    for div in artists_info:
        p_tags = div.find_elements(By.TAG_NAME,'p')
        if len(p_tags)==2:
            artists.append({"name":p_tags[0].text,"role":p_tags[1].text})
        else:
            artists.append({"name":p_tags[0].text,"role":''})


    program_info = driver.find_elements(By.CSS_SELECTOR,"div.pdp-inner-right-1:nth-child(2)")
    programs = []
    for div in program_info:
        curr_pair = {}
        divs = div.find_elements(By.TAG_NAME,'div')
        for item in divs:
            if "program-composer subhead4" == item.get_attribute('class'):
                if item.text:
                    curr_pair['composer'] = item.text
            elif "program-title-inner" in item.get_attribute('class'):
                curr_pair['piece'] = item.text
            if len(curr_pair)==2:
                programs.append(curr_pair)
                curr_pair={}

    driver.quit()
    
    return {"event":{"concert_title":event_name,'concert_info':{"performances":performances,"artists":artists,"programs":programs}}}
    