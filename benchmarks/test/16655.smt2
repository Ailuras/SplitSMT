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

(declare-sort var2652 0)
(declare-sort var3340 0)
(declare-sort var2251 0)
(declare-sort var2228 0)
(declare-sort var548 0)
(declare-sort var1599 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3340_isOverPayload/-95001326 (Int Int) Bool)
(declare-fun var2251-init () var2251)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-901862667 (String Int) String)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun append/-1031950772 (String var2228) String)
(declare-fun cast-from-var2652-to-var2228 (var2652) var2228)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/1593485778 (var2251 String) void)
(declare-fun getMessage/849299655 (var1599) String)
(declare-fun cast-from-var2251-to-var1599 (var2251) var1599)
(declare-fun var548_error/377575788 (var548 String String String String var1599) void)
(declare-const null-var2652 var2652)
(declare-const null-Int Int)
(declare-const var3340-logger var548)
(declare-const var2165 var2652) ; Statement: r6 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var2165 null-var2652)))
(declare-const var1613 Int) ; Statement: i1 := @parameter1: int 
(assert (not (= var1613 null-Int)))
(declare-const var2959 Int) ; Statement: l0 := @parameter2: long 
(assert (not (= var2959 null-Int)))
 ; Statement: if i1 > 0 goto $z0 = staticinvoke <org.apache.dubbo.remoting.transport.AbstractCodec: boolean isOverPayload(int,long)>(i1, l0) 
(assert (> var1613 0)) ; Cond: i1 > 0 
(define-const var1076 Bool (var3340_isOverPayload/-95001326 var1613 var2959)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.remoting.transport.AbstractCodec: boolean isOverPayload(int,long)>(i1, l0) 
 ; Statement: if $z0 == 0 goto return 
(assert (not (= (ite var1076 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3126 var2251 var2251-init) ; Statement: $r0 = new org.apache.dubbo.remoting.transport.ExceedPayloadLimitException 
(define-const var3577 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3577)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3577!1 String)
(assert (= var3577!1 ""))
(assert true)
(define-const var1137 String (append/672562846 var3577!1 "Data length too large: ")) ; Statement: $r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Data length too large: ") 
(declare-const var3577!2 String)
(assert (= var3577!2 (str.++ var3577!1 "Data length too large: ")))
(assert true)
(define-const var53 String (append/-901862667 var1137 var2959)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>(l0) 
(declare-const var1137!1 String)
(assert (str.prefixof var1137 var1137!1))
(assert true)
(define-const var2755 String (append/672562846 var53 ", max payload: ")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", max payload: ") 
(declare-const var53!1 String)
(assert (= var53!1 (str.++ var53 ", max payload: ")))
(assert true)
(define-const var3545 String (append/-1001720160 var2755 var1613)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i1) 
(declare-const var2755!1 String)
(assert (str.prefixof var2755 var2755!1))
(assert true)
(define-const var2368 String (append/672562846 var3545 ", channel: ")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", channel: ") 
(declare-const var3545!1 String)
(assert (= var3545!1 (str.++ var3545 ", channel: ")))
(assert true)
(define-const var1191 String (append/-1031950772 var2368 (cast-from-var2652-to-var2228 var2165))) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r6) 
(declare-const var2368!1 String)
(assert (str.prefixof var2368 var2368!1))
(assert true)
(define-const var492 String (toString/-2075883882 var1191)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/1593485778 var3126 var492)) ; Statement: specialinvoke $r0.<org.apache.dubbo.remoting.transport.ExceedPayloadLimitException: void <init>(java.lang.String)>($r9) 

(declare-const var3126!1 var2251)
(declare-const var492!1 String)
(define-const var2131 var548 var3340-logger) ; Statement: $r10 = <org.apache.dubbo.remoting.transport.AbstractCodec: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(assert true)
(define-const var962 String (getMessage/849299655 (cast-from-var2251-to-var1599 var3126!1))) ; Statement: $r11 = virtualinvoke $r0.<org.apache.dubbo.remoting.transport.ExceedPayloadLimitException: java.lang.String getMessage()>() 
;(assert (var548_error/377575788 var2131 "6-10" "" "" var962 (cast-from-var2251-to-var1599 var3126!1))) ; Statement: interfaceinvoke $r10.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("6-10", "", "", $r11, $r0) 

(declare-const var2131!1 var548)
(declare-const var2528 String)
(declare-const var3800 String)
(declare-const var3800!1 String)
(declare-const var962!1 String)
(declare-const var3126!2 var2251)
 ; Statement: throw $r0 
(check-sat)
; {var3340_isOverPayload/-95001326=([int, long], boolean), var2251-init=([], org.apache.dubbo.remoting.transport.ExceedPayloadLimitException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2652-to-var2228=([org.apache.dubbo.remoting.Channel], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/1593485778=([org.apache.dubbo.remoting.transport.ExceedPayloadLimitException, java.lang.String], void), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var2251-to-var1599=([org.apache.dubbo.remoting.transport.ExceedPayloadLimitException], java.lang.Throwable), var548_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var2652=org.apache.dubbo.remoting.Channel, var2165=r6, var1613=i1, var2959=l0, var3340=org.apache.dubbo.remoting.transport.AbstractCodec, var1076=$z0, var2251=org.apache.dubbo.remoting.transport.ExceedPayloadLimitException, var3126=$r0, var3577=$r1, var1137=$r2, var53=$r3, var2755=$r4, var3545=$r5, var2368=$r7, var2228=java.lang.Object, var1191=$r8, var492=$r9, var548=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2131=$r10, var1599=java.lang.Throwable, var962=$r11, var2528="6-10", var3800=""}
; {org.apache.dubbo.remoting.Channel=var2652, r6=var2165, i1=var1613, l0=var2959, org.apache.dubbo.remoting.transport.AbstractCodec=var3340, $z0=var1076, org.apache.dubbo.remoting.transport.ExceedPayloadLimitException=var2251, $r0=var3126, $r1=var3577, $r2=var1137, $r3=var53, $r4=var2755, $r5=var3545, $r7=var2368, java.lang.Object=var2228, $r8=var1191, $r9=var492, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var548, $r10=var2131, java.lang.Throwable=var1599, $r11=var962, "6-10"=var2528, ""=var3800}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r6 := @parameter0: org.apache.dubbo.remoting.Channel;	i1 := @parameter1: int;	l0 := @parameter2: long;	if i1 > 0 goto $z0 = staticinvoke <org.apache.dubbo.remoting.transport.AbstractCodec: boolean isOverPayload(int,long)>(i1, l0);	$z0 = staticinvoke <org.apache.dubbo.remoting.transport.AbstractCodec: boolean isOverPayload(int,long)>(i1, l0);	if $z0 == 0 goto return;	$r0 = new org.apache.dubbo.remoting.transport.ExceedPayloadLimitException;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Data length too large: ");	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>(l0);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", max payload: ");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i1);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", channel: ");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r0.<org.apache.dubbo.remoting.transport.ExceedPayloadLimitException: void <init>(java.lang.String)>($r9);	$r10 = <org.apache.dubbo.remoting.transport.AbstractCodec: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r11 = virtualinvoke $r0.<org.apache.dubbo.remoting.transport.ExceedPayloadLimitException: java.lang.String getMessage()>();	interfaceinvoke $r10.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("6-10", "", "", $r11, $r0);	throw $r0
;block_num 3