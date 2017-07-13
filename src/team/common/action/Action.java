package team.common.action;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*Action���� Ŭ��������..
 * Action�������̽��� �߻�޼��带 �������̵������ν� Ŭ���̾�Ʈ�� ��ûó�� ���¸� �԰�ȭ��Ŵ*/
public interface Action  {
	//Ư�� Ŭ���̾�Ʈ�� ��û�� �����ϰ� �� ��� ���� ActionForwardŬ���� Ÿ������ ��ȯ
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response)  throws Exception;
}
