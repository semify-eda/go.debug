Logging
#######

The *ErrorAnalyzer* dumps messages in order to providing information to the user. The messages are dumped to the console and to a log file (default file name ``eaLogFile.log``).

Format
======

A logging Message has the following format.

  ``(EA.<Phase>) <Severity> [<MsgID>][<SubMsgID>] <Msg>``

**Phase**: Actual phase of ErrorAnalyzer analysis. The phases are based on the UVM phasing concept. The following phases are used:

- Build
- Run
- Check
- Report
 
**Severity**: Severity indicates importance of a message. Available severity levels are
  
- FATAL
- ERROR
- WARNING
- INFO
- DEBUG
  
The messages are filtered based on the verbosity level assigned to each message. The verbosity threshold for logging to the console and logging to the log file can be defined separately. Messages of severity FATAL, ERROR and WARNING cannot be filtered at all.
  
**MsgID**: The message ID identifies the cathegory of a message. It consists of maximal 10 uppercase letters. The first letter(s) indicate a certain group of messages.
  - EA: General *ErrorAnalyzer* related messages
  - CFG: Configuration related messages
  - A: Analyzer related messages
  - REP: REporting releated messages
  - DUMP: Waveform file dumping related messages
 
**SubMsgID** (optional): The sub message ID provides a fine-grained categorization of a message
  
**Msg**: Message content. Can be a multi-line string. The text of all new lines belonging to the message is always indented. 
A none space character at the first column of a line indicates the begin of a new message.

  
