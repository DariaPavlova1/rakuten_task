# Flask-Docker-App

## Set up & Installation.

### 1 .Clone/Fork the git repo and create a virtual environment 
                    
**Windows**
          
```bash
git clone https://github.com/DariaPavlova1/rakuten_task.git
cd rakuten_task
py -3 -m venv venv

```
          
**macOS/Linux**
          
```bash
git clone https://github.com/DariaPavlova1/rakuten_task.git
cd rakuten_task
python3 -m venv venv

```
### 2 .Activate the environment
          
**Windows** 

```venv\Scripts\activate```
          
**macOS/Linux**

```. venv/bin/activate```
or
```source venv/bin/activate```


### 3 .Install the requirements

Applies for windows/macOS/Linux

```
pip install -r requirements.txt
```

### 5. Run the application
`python app.py`

## OR just to simply build and run Docker container with python-flask application run the script

`bash script.sh` or
`. script.sh`
