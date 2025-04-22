# MacInfo _**macOS System Information Dialog**_

MacInfo is a lightweight shell script that leverages [SwiftDialog](https://github.com/swiftDialog/) and built‑in macOS commands to present key device details in a clean, interactive dialog. Perfect for HelpDesk agents who need to quickly gather system info during support calls. Tested in Jamf Pro but compatible with any MDM.

---

## Reports On

- **Uptime** (in days)  
- **Logged‑in user**  
- **Serial number**  
- **Architecture** (e.g. x86_64, arm64)  
- **Hostname**  
- **Current IP address(es)**  
- **MAC address** (Wi‑Fi interface)  
- **Jamf Pro client version** (if jamf CLI is installed)  
- **macOS product version**  
- **Customizable dialog icon, size, and content**  

---

## Prerequisites

- **macOS** (12.0+ recommended)  
- **SwiftDialog** installed  
- **jamf** CLI (optional, for Jamf version reporting)  

---

## Installation

1. **Clone the repo**  
   ```bash
   git clone https://github.com/YOUR_USERNAME/macinfo.git
   cd macinfo
   ```
2. **Make the script executable**  
   ```bash
   chmod +x macinfo.sh
   ```

---

## Usage

Run the script directly from Terminal or via your MDM:

```bash
./macinfo.sh
```

The dialog will display all collected system details. Click the button to dismiss.

---

## Deployment with Jamf Pro

1. Upload `macinfo.sh` as a Script in Jamf Pro.  
2. Create a Policy scoped to your target Macs.  
3. In the “Scripts” payload, add `macinfo.sh` add to self service so users can access whenever. 

---

## Customization

- **Icon**: Edit the `icon` variable at the top of `macinfo.sh` to point to your preferred image URL.  
- **Dialog Title & Size**: Adjust the `--title`, `--width`, and `--height` flags in the `launchDialog()` function.  
- **Displayed Fields**: Modify the `--message` string in `launchDialog()` to add/remove fields or change formatting (HTML `<br>` tags supported).  

---

## Variables Breakdown

| Variable           | Description                                    |
| ------------------ | ---------------------------------------------- |
| `serial_number`    | Device serial from `system_profiler`           |
| `hostname`         | Hostname of the Mac                            |
| `UNAME_MACHINE`    | CPU architecture (`uname -m`)                  |
| `current_ip`       | Non‑loopback IP address(es)                    |
| `jamf_version`     | Jamf Pro client version (`jamf -version`)      |
| `macOS`            | macOS version (`sw_vers -productVersion`)      |
| `consoleuser`      | Currently logged‑in user                       |
| `uptime`           | Uptime in days (calculated from boot time)     |
| `MAC`              | Wi‑Fi interface MAC address                    |

---

## Tested On

- macOS Monterey (12.x)  
- macOS Ventura (13.x)  
- Jamf Pro 10.x  


---

## To Do

- Add CPU & memory usage statistics  
- Support multiple network interfaces  
- Localize dialog labels for other languages  

