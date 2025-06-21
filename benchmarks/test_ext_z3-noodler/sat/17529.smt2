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

(declare-sort var2018 0)
(declare-sort var223 0)
(declare-sort var3649 0)
(declare-sort var2958 0)
(declare-sort var785 0)
(declare-sort var2774 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun needReconnect/33813463 (var2018) Bool)
(declare-fun getChannel/832678069 (var2018) var3649)
(declare-fun var2958-init () var2958)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getUrl/1588539622 (var2774) var785)
(declare-fun cast-from-var2018-to-var2774 (var2018) var2774)
(declare-fun append/-1031950772 (String var223) String)
(declare-fun cast-from-var785-to-var223 (var785) var223)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-2142452957 (var2958 var3649 String) void)
(declare-fun cast-from-var2018-to-var3649 (var2018) var3649)
(declare-const null-var2018 var2018)
(declare-const null-var223 var223)
(declare-const null-Bool Bool)
(declare-const null-var3649 var3649)
(declare-const var2279 var2018) ; Statement: r0 := @this: org.apache.dubbo.remoting.transport.AbstractClient 
(assert (not (= var2279 null-var2018)))
(declare-const var3967 var223) ; Statement: r7 := @parameter0: java.lang.Object 
(assert (not (= var3967 null-var223)))
(declare-const var2119 Bool) ; Statement: z2 := @parameter1: boolean 
(assert (not (= var2119 null-Bool)))
(define-const var997 Bool (needReconnect/33813463 var2279)) ; Statement: $z0 = r0.<org.apache.dubbo.remoting.transport.AbstractClient: boolean needReconnect> 
 ; Statement: if $z0 == 0 goto $r8 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.AbstractClient: org.apache.dubbo.remoting.Channel getChannel()>() 
(assert (= (ite var997 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3538 var3649 (getChannel/832678069 var2279)) ; Statement: $r8 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.AbstractClient: org.apache.dubbo.remoting.Channel getChannel()>() 
 ; Statement: if $r8 == null goto $r1 = new org.apache.dubbo.remoting.RemotingException 
(assert (= var3538 null-var3649)) ; Cond: $r8 == null 
(define-const var1774 var2958 var2958-init) ; Statement: $r1 = new org.apache.dubbo.remoting.RemotingException 
(define-const var1036 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1036)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1036!1 String)
(assert (= var1036!1 ""))
(assert true)
(define-const var3107 String (append/672562846 var1036!1 "message can not send, because channel is closed . url:")) ; Statement: $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("message can not send, because channel is closed . url:") 
(declare-const var1036!2 String)
(assert (= var1036!2 (str.++ var1036!1 "message can not send, because channel is closed . url:")))
(assert true)
(define-const var2070 var785 (getUrl/1588539622 (cast-from-var2018-to-var2774 var2279))) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.AbstractClient: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var3017 String (append/-1031950772 var3107 (cast-from-var785-to-var223 var2070))) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r3) 
(declare-const var3107!1 String)
(assert (str.prefixof var3107 var3107!1))
(assert true)
(define-const var3069 String (toString/-2075883882 var3017)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-2142452957 var1774 (cast-from-var2018-to-var3649 var2279) var3069)) ; Statement: specialinvoke $r1.<org.apache.dubbo.remoting.RemotingException: void <init>(org.apache.dubbo.remoting.Channel,java.lang.String)>(r0, $r6) 

(declare-const var1774!1 var2958)
(declare-const var2279!1 var2018)
(declare-const var3069!1 String)
 ; Statement: throw $r1 
(check-sat)
; {needReconnect/33813463=([org.apache.dubbo.remoting.transport.AbstractClient], boolean), getChannel/832678069=([org.apache.dubbo.remoting.transport.AbstractClient], org.apache.dubbo.remoting.Channel), var2958-init=([], org.apache.dubbo.remoting.RemotingException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getUrl/1588539622=([org.apache.dubbo.remoting.transport.AbstractPeer], org.apache.dubbo.common.URL), cast-from-var2018-to-var2774=([org.apache.dubbo.remoting.transport.AbstractClient], org.apache.dubbo.remoting.transport.AbstractPeer), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var785-to-var223=([org.apache.dubbo.common.URL], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-2142452957=([org.apache.dubbo.remoting.RemotingException, org.apache.dubbo.remoting.Channel, java.lang.String], void), cast-from-var2018-to-var3649=([org.apache.dubbo.remoting.transport.AbstractClient], org.apache.dubbo.remoting.Channel)}
; {var2018=org.apache.dubbo.remoting.transport.AbstractClient, var2279=r0, var223=java.lang.Object, var3967=r7, var2119=z2, var997=$z0, var3649=org.apache.dubbo.remoting.Channel, var3538=$r8, var2958=org.apache.dubbo.remoting.RemotingException, var1774=$r1, var1036=$r2, var3107=$r4, var785=org.apache.dubbo.common.URL, var2774=org.apache.dubbo.remoting.transport.AbstractPeer, var2070=$r3, var3017=$r5, var3069=$r6}
; {org.apache.dubbo.remoting.transport.AbstractClient=var2018, r0=var2279, java.lang.Object=var223, r7=var3967, z2=var2119, $z0=var997, org.apache.dubbo.remoting.Channel=var3649, $r8=var3538, org.apache.dubbo.remoting.RemotingException=var2958, $r1=var1774, $r2=var1036, $r4=var3107, org.apache.dubbo.common.URL=var785, org.apache.dubbo.remoting.transport.AbstractPeer=var2774, $r3=var2070, $r5=var3017, $r6=var3069}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.transport.AbstractClient;	r7 := @parameter0: java.lang.Object;	z2 := @parameter1: boolean;	$z0 = r0.<org.apache.dubbo.remoting.transport.AbstractClient: boolean needReconnect>;	if $z0 == 0 goto $r8 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.AbstractClient: org.apache.dubbo.remoting.Channel getChannel()>();	$r8 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.AbstractClient: org.apache.dubbo.remoting.Channel getChannel()>();	if $r8 == null goto $r1 = new org.apache.dubbo.remoting.RemotingException;	$r1 = new org.apache.dubbo.remoting.RemotingException;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("message can not send, because channel is closed . url:");	$r3 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.AbstractClient: org.apache.dubbo.common.URL getUrl()>();	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r3);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r1.<org.apache.dubbo.remoting.RemotingException: void <init>(org.apache.dubbo.remoting.Channel,java.lang.String)>(r0, $r6);	throw $r1
;block_num 3