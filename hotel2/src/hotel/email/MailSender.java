/*
 * ���̹� ������ �̿��� ���� �߼� ���� �ҽ��ڵ�
 * 
 * ���� ������ �̿��� ���� �߼��� �Ʒ��� URL ����
 * https://shared.co.kr/219
 * �ۼ���: 23.07.11.ȭ
 * �ۼ���: ������
 */
package hotel.email;

import java.util.Properties;
import java.util.UUID;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailSender 
{
	
	//��ū ����
	public String maketoken()
	{
		String token = UUID.randomUUID().toString().substring(0,8);
		System.out.println(token);
		return token;
	}
	
	//�޼ҵ�
	//�̸��� ����
	public boolean MailSend(String from,String to,String id,String pw,String title,String body)
	{		
		try
		{  
			System.out.println("send stage 01");
			
			Properties clsProp = System.getProperties();
			
			// ���� ���� �ּ�
			clsProp.put( "mail.smtp.host", "smtp.naver.com" );
			
			// ���� ���� ��Ʈ ��ȣ
			clsProp.put( "mail.smtp.port", 465 );			
			
			System.out.println("send stage 02");
			
			// ������ �ʿ��ϸ� �Ʒ��� ���� �����Ѵ�.
			clsProp.put("mail.smtp.auth", "true"); 
			clsProp.put("mail.smtp.ssl.enable", "true"); 
			clsProp.put("mail.smtp.ssl.trust", "smtp.naver.com");			
			
			System.out.println("send stage 03");
			
			Session clsSession = Session.getInstance( clsProp, new Authenticator(){
					public PasswordAuthentication getPasswordAuthentication()
					{
						// ���� ���̵�/��й�ȣ�� �����Ѵ�.
						return new PasswordAuthentication( id, pw );
					}
				} );
			
			System.out.println("send stage 04");
			
			Message clsMessage = new MimeMessage( clsSession );
			
			// �߽��� �̸��� �ּҸ� �����Ѵ�.
			clsMessage.setFrom( new InternetAddress( from ) );
			
			System.out.println("send stage 05");
			
			// ������ �̸��� �ּҸ� �����Ѵ�.
			clsMessage.addRecipient( Message.RecipientType.TO, new InternetAddress( to ) );
			
			System.out.println("send stage 06");
			
			// ������ �����Ѵ�.
			clsMessage.setSubject( title );
			
			// ���� ������ �����Ѵ�. �ҽ� �ڵ带 euc-kr �� �ۼ��Ͽ��� charset �� euckr �� ������.
			clsMessage.setContent( body , "text/html;charset=euckr"); //text/Ÿ�Կ� ���� ������.
			
			System.out.println("send stage 07");
			
			// ���� ����
			Transport.send( clsMessage );
			
			System.out.println("send stage 08");
		}
		catch( Exception e )
		{
			e.printStackTrace();
			return false;
		}		
		return true;
	}
}