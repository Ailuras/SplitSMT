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

(declare-sort var3660 0)
(declare-sort var131 0)
(declare-sort var3567 0)
(declare-sort var529 0)
(declare-sort var206 0)
(declare-sort var630 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var131_getPayload/1230319912 (var3660) Int)
(declare-fun var131_isOverPayload/-95001326 (Int Int) Bool)
(declare-fun var3567-init () var3567)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-901862667 (String Int) String)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun append/-1031950772 (String var529) String)
(declare-fun cast-from-var3660-to-var529 (var3660) var529)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/1593485778 (var3567 String) void)
(declare-fun getMessage/849299655 (var630) String)
(declare-fun cast-from-var3567-to-var630 (var3567) var630)
(declare-fun var206_error/377575788 (var206 String String String String var630) void)
(declare-const null-var3660 var3660)
(declare-const null-Int Int)
(declare-const var131-logger var206)
(declare-const var1610 var3660) ; Statement: r0 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var1610 null-var3660)))
(declare-const var3587 Int) ; Statement: l1 := @parameter1: long 
(assert (not (= var3587 null-Int)))
(define-const var185 Int (var131_getPayload/1230319912 var1610)) ; Statement: i0 = staticinvoke <org.apache.dubbo.remoting.transport.AbstractCodec: int getPayload(org.apache.dubbo.remoting.Channel)>(r0) 
(define-const var1105 Bool (var131_isOverPayload/-95001326 var185 var3587)) ; Statement: z0 = staticinvoke <org.apache.dubbo.remoting.transport.AbstractCodec: boolean isOverPayload(int,long)>(i0, l1) 
 ; Statement: if z0 == 0 goto return 
(assert (not (= (ite var1105 1 0) 0))) ; Negate: Cond: z0 == 0  
(define-const var1982 var3567 var3567-init) ; Statement: $r1 = new org.apache.dubbo.remoting.transport.ExceedPayloadLimitException 
(define-const var3509 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3509)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3509!1 String)
(assert (= var3509!1 ""))
(assert true)
(define-const var1520 String (append/672562846 var3509!1 "Data length too large: ")) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Data length too large: ") 
(declare-const var3509!2 String)
(assert (= var3509!2 (str.++ var3509!1 "Data length too large: ")))
(assert true)
(define-const var430 String (append/-901862667 var1520 var3587)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>(l1) 
(declare-const var1520!1 String)
(assert (str.prefixof var1520 var1520!1))
(assert true)
(define-const var239 String (append/672562846 var430 ", max payload: ")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", max payload: ") 
(declare-const var430!1 String)
(assert (= var430!1 (str.++ var430 ", max payload: ")))
(assert true)
(define-const var3390 String (append/-1001720160 var239 var185)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var239!1 String)
(assert (str.prefixof var239 var239!1))
(assert true)
(define-const var2443 String (append/672562846 var3390 ", channel: ")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", channel: ") 
(declare-const var3390!1 String)
(assert (= var3390!1 (str.++ var3390 ", channel: ")))
(assert true)
(define-const var2367 String (append/-1031950772 var2443 (cast-from-var3660-to-var529 var1610))) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0) 
(declare-const var2443!1 String)
(assert (str.prefixof var2443 var2443!1))
(assert true)
(define-const var343 String (toString/-2075883882 var2367)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/1593485778 var1982 var343)) ; Statement: specialinvoke $r1.<org.apache.dubbo.remoting.transport.ExceedPayloadLimitException: void <init>(java.lang.String)>($r9) 

(declare-const var1982!1 var3567)
(declare-const var343!1 String)
(define-const var1285 var206 var131-logger) ; Statement: $r10 = <org.apache.dubbo.remoting.transport.AbstractCodec: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(assert true)
(define-const var1158 String (getMessage/849299655 (cast-from-var3567-to-var630 var1982!1))) ; Statement: $r11 = virtualinvoke $r1.<org.apache.dubbo.remoting.transport.ExceedPayloadLimitException: java.lang.String getMessage()>() 
;(assert (var206_error/377575788 var1285 "6-10" "" "" var1158 (cast-from-var3567-to-var630 var1982!1))) ; Statement: interfaceinvoke $r10.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("6-10", "", "", $r11, $r1) 

(declare-const var1285!1 var206)
(declare-const var2635 String)
(declare-const var3447 String)
(declare-const var3447!1 String)
(declare-const var1158!1 String)
(declare-const var1982!2 var3567)
 ; Statement: throw $r1 
(check-sat)
; {var131_getPayload/1230319912=([org.apache.dubbo.remoting.Channel], int), var131_isOverPayload/-95001326=([int, long], boolean), var3567-init=([], org.apache.dubbo.remoting.transport.ExceedPayloadLimitException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3660-to-var529=([org.apache.dubbo.remoting.Channel], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/1593485778=([org.apache.dubbo.remoting.transport.ExceedPayloadLimitException, java.lang.String], void), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var3567-to-var630=([org.apache.dubbo.remoting.transport.ExceedPayloadLimitException], java.lang.Throwable), var206_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var3660=org.apache.dubbo.remoting.Channel, var1610=r0, var3587=l1, var131=org.apache.dubbo.remoting.transport.AbstractCodec, var185=i0, var1105=z0, var3567=org.apache.dubbo.remoting.transport.ExceedPayloadLimitException, var1982=$r1, var3509=$r2, var1520=$r3, var430=$r4, var239=$r5, var3390=$r6, var2443=$r7, var529=java.lang.Object, var2367=$r8, var343=$r9, var206=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1285=$r10, var630=java.lang.Throwable, var1158=$r11, var2635="6-10", var3447=""}
; {org.apache.dubbo.remoting.Channel=var3660, r0=var1610, l1=var3587, org.apache.dubbo.remoting.transport.AbstractCodec=var131, i0=var185, z0=var1105, org.apache.dubbo.remoting.transport.ExceedPayloadLimitException=var3567, $r1=var1982, $r2=var3509, $r3=var1520, $r4=var430, $r5=var239, $r6=var3390, $r7=var2443, java.lang.Object=var529, $r8=var2367, $r9=var343, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var206, $r10=var1285, java.lang.Throwable=var630, $r11=var1158, "6-10"=var2635, ""=var3447}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.remoting.Channel;	l1 := @parameter1: long;	i0 = staticinvoke <org.apache.dubbo.remoting.transport.AbstractCodec: int getPayload(org.apache.dubbo.remoting.Channel)>(r0);	z0 = staticinvoke <org.apache.dubbo.remoting.transport.AbstractCodec: boolean isOverPayload(int,long)>(i0, l1);	if z0 == 0 goto return;	$r1 = new org.apache.dubbo.remoting.transport.ExceedPayloadLimitException;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Data length too large: ");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>(l1);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", max payload: ");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", channel: ");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r1.<org.apache.dubbo.remoting.transport.ExceedPayloadLimitException: void <init>(java.lang.String)>($r9);	$r10 = <org.apache.dubbo.remoting.transport.AbstractCodec: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r11 = virtualinvoke $r1.<org.apache.dubbo.remoting.transport.ExceedPayloadLimitException: java.lang.String getMessage()>();	interfaceinvoke $r10.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("6-10", "", "", $r11, $r1);	throw $r1
;block_num 2