(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var1738 0)
(declare-sort var3790 0)
(declare-sort var873 0)
(declare-sort var2344 0)
(declare-sort var1820 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var873 String) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1820_getEncoder/-814672977 () var2344)
(declare-fun getBytes/1068683673 (String) (Array Int Int))
(declare-fun encodeToString/1148501555 (var2344 (Array Int Int)) String)
(declare-fun var3790_setAttachment/245726651 (var3790 String String) void)
(declare-const null-var1738 var1738)
(declare-const null-var3790 var3790)
(declare-const null-var873 var873)
(declare-const var1086 var1738) ; Statement: r16 := @this: org.apache.dubbo.auth.BasicAuthenticator 
(assert (not (= var1086 null-var1738)))
(declare-const var1460 var3790) ; Statement: r15 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var1460 null-var3790)))
(declare-const var3893 var873) ; Statement: r0 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var3893 null-var873)))
(assert true)
(define-const var3516 String (getParameter/-1307325648 var3893 "username")) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("username") 
(assert true)
(define-const var1819 String (getParameter/-1307325648 var3893 "password")) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("password") 
(define-const var3381 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3381)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3381!1 String)
(assert (= var3381!1 ""))
(assert true)
(define-const var587 String (append/672562846 var3381!1 var3516)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var3381!2 String)
(assert (= var3381!2 (str.++ var3381!1 var3516)))
(assert true)
(define-const var791 String (append/672562846 var587 ":")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":") 
(declare-const var587!1 String)
(assert (= var587!1 (str.++ var587 ":")))
(assert true)
(define-const var3595 String (append/672562846 var791 var1819)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var791!1 String)
(assert (= var791!1 (str.++ var791 var1819)))
(assert true)
(define-const var1412 String (toString/-2075883882 var3595)) ; Statement: r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var2642 var2344 var1820_getEncoder/-814672977) ; Statement: $r9 = staticinvoke <java.util.Base64: java.util.Base64$Encoder getEncoder()>() 
(assert true)
(define-const var2914 (Array Int Int) (getBytes/1068683673 var1412)) ; Statement: $r8 = virtualinvoke r7.<java.lang.String: byte[] getBytes()>() 
(assert true)
(define-const var2308 String (encodeToString/1148501555 var2642 var2914)) ; Statement: r10 = virtualinvoke $r9.<java.util.Base64$Encoder: java.lang.String encodeToString(byte[])>($r8) 
(define-const var2794 String String-init) ; Statement: $r11 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2794)) ; Statement: specialinvoke $r11.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2794!1 String)
(assert (= var2794!1 ""))
(assert true)
(define-const var1766 String (append/672562846 var2794!1 "Basic ")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Basic ") 
(declare-const var2794!2 String)
(assert (= var2794!2 (str.++ var2794!1 "Basic ")))
(assert true)
(define-const var3124 String (append/672562846 var1766 var2308)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r10) 
(declare-const var1766!1 String)
(assert (= var1766!1 (str.++ var1766 var2308)))
(assert true)
(define-const var1867 String (toString/-2075883882 var3124)) ; Statement: r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3790_setAttachment/245726651 var1460 "authorization" var1867)) ; Statement: interfaceinvoke r15.<org.apache.dubbo.rpc.Invocation: void setAttachment(java.lang.String,java.lang.String)>("authorization", r14) 

(declare-const var1460!1 var3790)
(declare-const var2481 String)
(declare-const var1867!1 String)
 ; Statement: return 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1820_getEncoder/-814672977=([], java.util.Base64$Encoder), getBytes/1068683673=([java.lang.String], byte[]), encodeToString/1148501555=([java.util.Base64$Encoder, byte[]], java.lang.String), var3790_setAttachment/245726651=([org.apache.dubbo.rpc.Invocation, java.lang.String, java.lang.String], void)}
; {var1738=org.apache.dubbo.auth.BasicAuthenticator, var1086=r16, var3790=org.apache.dubbo.rpc.Invocation, var1460=r15, var873=org.apache.dubbo.common.URL, var3893=r0, var3516=r1, var1819=r2, var3381=$r3, var587=$r4, var791=$r5, var3595=$r6, var1412=r7, var2344=java.util.Base64$Encoder, var1820=java.util.Base64, var2642=$r9, var2914=$r8, var2308=r10, var2794=$r11, var1766=$r12, var3124=$r13, var1867=r14, var2481="authorization"}
; {org.apache.dubbo.auth.BasicAuthenticator=var1738, r16=var1086, org.apache.dubbo.rpc.Invocation=var3790, r15=var1460, org.apache.dubbo.common.URL=var873, r0=var3893, r1=var3516, r2=var1819, $r3=var3381, $r4=var587, $r5=var791, $r6=var3595, r7=var1412, java.util.Base64$Encoder=var2344, java.util.Base64=var1820, $r9=var2642, $r8=var2914, r10=var2308, $r11=var2794, $r12=var1766, $r13=var3124, r14=var1867, "authorization"=var2481}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.String: byte[] getBytes()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.String toString()>": 2,"<java.lang.String: byte[] getBytes()>": 1}
;stmts r16 := @this: org.apache.dubbo.auth.BasicAuthenticator;	r15 := @parameter0: org.apache.dubbo.rpc.Invocation;	r0 := @parameter1: org.apache.dubbo.common.URL;	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("username");	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("password");	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	$r9 = staticinvoke <java.util.Base64: java.util.Base64$Encoder getEncoder()>();	$r8 = virtualinvoke r7.<java.lang.String: byte[] getBytes()>();	r10 = virtualinvoke $r9.<java.util.Base64$Encoder: java.lang.String encodeToString(byte[])>($r8);	$r11 = new java.lang.StringBuilder;	specialinvoke $r11.<java.lang.StringBuilder: void <init>()>();	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Basic ");	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r10);	r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke r15.<org.apache.dubbo.rpc.Invocation: void setAttachment(java.lang.String,java.lang.String)>("authorization", r14);	return
;block_num 1