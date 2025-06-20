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

(declare-sort var491 0)
(declare-sort var1313 0)
(declare-sort var1644 0)
(declare-sort var784 0)
(declare-sort var149 0)
(declare-sort var3805 0)
(declare-sort var2883 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var1644) String)
(declare-fun cast-from-var1313-to-var1644 (var1313) var1644)
(declare-fun cast-from-var149-to-var1644 (var149) var1644)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3805_warn/1431914100 (var3805 String String String String) void)
(declare-const null-var491 var491)
(declare-const null-var1313 var1313)
(declare-const null-var1644 var1644)
(declare-const null-var784 var784)
(declare-const null-var149 var149)
(declare-const var2883-logger var3805)
(declare-const var3186 var491) ; Statement: r1 := @parameter0: org.apache.dubbo.remoting.exchange.Response 
(assert (not (= var3186 null-var491)))
(declare-const var3680 var1313) ; Statement: r3 := @parameter1: org.apache.dubbo.remoting.exchange.ExchangeChannel 
(assert (not (= var3680 null-var1313)))
(declare-const var2985 var1644) ; Statement: r4 := @parameter2: java.lang.Object 
(assert (not (= var2985 null-var1644)))
(declare-const var724 var784) ; Statement: r0 := @parameter3: java.lang.Throwable 
(assert (not (= var724 null-var784)))
 ; Statement: if r0 != null goto virtualinvoke r1.<org.apache.dubbo.remoting.exchange.Response: void setStatus(byte)>(70) 
(assert (not (not (= var724 null-var784)))) ; Negate: Cond: r0 != null  
(declare-const var3883 var149) ; Statement: $r5 := @caughtexception 
(assert (not (= var3883 null-var149)))
(define-const var3575 var3805 var2883-logger) ; Statement: $r7 = <org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeHandler: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var951 String String-init) ; Statement: $r6 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var951)) ; Statement: specialinvoke $r6.<java.lang.StringBuilder: void <init>()>() 
(declare-const var951!1 String)
(assert (= var951!1 ""))
(assert true)
(define-const var325 String (append/672562846 var951!1 "Send result to consumer failed, channel is ")) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Send result to consumer failed, channel is ") 
(declare-const var951!2 String)
(assert (= var951!2 (str.++ var951!1 "Send result to consumer failed, channel is ")))
(assert true)
(define-const var1238 String (append/-1031950772 var325 (cast-from-var1313-to-var1644 var3680))) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r3) 
(declare-const var325!1 String)
(assert (str.prefixof var325 var325!1))
(assert true)
(define-const var855 String (append/672562846 var1238 ", msg is ")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", msg is ") 
(declare-const var1238!1 String)
(assert (= var1238!1 (str.++ var1238 ", msg is ")))
(assert true)
(define-const var1190 String (append/-1031950772 var855 (cast-from-var149-to-var1644 var3883))) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5) 
(declare-const var855!1 String)
(assert (str.prefixof var855 var855!1))
(assert true)
(define-const var2891 String (toString/-2075883882 var1190)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3805_warn/1431914100 var3575 "6-14" "" "" var2891)) ; Statement: interfaceinvoke $r7.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("6-14", "", "", $r12) 

(declare-const var3575!1 var3805)
(declare-const var3351 String)
(declare-const var2007 String)
(declare-const var2007!1 String)
(declare-const var2891!1 String)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1313-to-var1644=([org.apache.dubbo.remoting.exchange.ExchangeChannel], java.lang.Object), cast-from-var149-to-var1644=([org.apache.dubbo.remoting.RemotingException], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3805_warn/1431914100=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void)}
; {var491=org.apache.dubbo.remoting.exchange.Response, var3186=r1, var1313=org.apache.dubbo.remoting.exchange.ExchangeChannel, var3680=r3, var1644=java.lang.Object, var2985=r4, var784=java.lang.Throwable, var724=r0, var149=org.apache.dubbo.remoting.RemotingException, var3883=$r5, var3805=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2883=org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeHandler, var3575=$r7, var951=$r6, var325=$r8, var1238=$r9, var855=$r10, var1190=$r11, var2891=$r12, var3351="6-14", var2007=""}
; {org.apache.dubbo.remoting.exchange.Response=var491, r1=var3186, org.apache.dubbo.remoting.exchange.ExchangeChannel=var1313, r3=var3680, java.lang.Object=var1644, r4=var2985, java.lang.Throwable=var784, r0=var724, org.apache.dubbo.remoting.RemotingException=var149, $r5=var3883, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3805, org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeHandler=var2883, $r7=var3575, $r6=var951, $r8=var325, $r9=var1238, $r10=var855, $r11=var1190, $r12=var2891, "6-14"=var3351, ""=var2007}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: org.apache.dubbo.remoting.exchange.Response;	r3 := @parameter1: org.apache.dubbo.remoting.exchange.ExchangeChannel;	r4 := @parameter2: java.lang.Object;	r0 := @parameter3: java.lang.Throwable;	if r0 != null goto virtualinvoke r1.<org.apache.dubbo.remoting.exchange.Response: void setStatus(byte)>(70);	$r5 := @caughtexception;	$r7 = <org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeHandler: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r6 = new java.lang.StringBuilder;	specialinvoke $r6.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Send result to consumer failed, channel is ");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r3);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", msg is ");	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r7.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("6-14", "", "", $r12);	return
;block_num 3