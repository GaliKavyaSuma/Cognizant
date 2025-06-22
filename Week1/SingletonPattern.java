class Logger
{
	private static final Logger instance =new Logger();
	private Logger()
	{
		System.out.println("Logger isntance created");
	}
	public static Logger getInstance()
	{
		return instance;
	}
	public void log(String message)
	{
		System.out.println("Log: "+message);
	}
	public static void main(String[] args)
	{
		Logger logger1=Logger.getInstance();
		Logger logger2=Logger.getInstance();
		if(logger1==logger2)
		{
			System.out.println("both are same instance");
		}
		else
		{
			System.out.println("they are different instnces");
		}
		logger1.log("this is from logger1");
		logger2.log("this is from logger2");
	}
}
