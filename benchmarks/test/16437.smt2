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

(declare-sort var248 0)
(declare-sort var3538 0)
(declare-sort var3811 0)
(declare-sort var396 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun var396_isNumber/1050655655 (String) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var248 var248)
(declare-const null-var3538 var3538)
(declare-const null-String String)
(declare-const var3559 var248) ; Statement: r8 := @this: org.apache.dubbo.remoting.telnet.support.command.ClearTelnetHandler 
(assert (not (= var3559 null-var248)))
(declare-const var1367 var3538) ; Statement: r9 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var1367 null-var3538)))
(declare-const var436 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var436 null-String)))
(define-const var1762 Int 100) ; Statement: i2 = 100 
(assert true)
(define-const var3154 Int (length/-134980193 var436)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
 ; Statement: if $i0 <= 0 goto $r1 = new java.lang.StringBuilder 
(assert (not (<= var3154 0))) ; Negate: Cond: $i0 <= 0  
(define-const var2639 Bool (var396_isNumber/1050655655 var436)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>(r0) 
 ; Statement: if $z0 != 0 goto $i1 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r0) 
(assert (not (not (= (ite var2639 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var981 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var981)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var981!1 String)
(assert (= var981!1 ""))
(assert true)
(define-const var1900 String (append/672562846 var981!1 "Illegal lines ")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Illegal lines ") 
(declare-const var981!2 String)
(assert (= var981!2 (str.++ var981!1 "Illegal lines ")))
(assert true)
(define-const var486 String (append/672562846 var1900 var436)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var1900!1 String)
(assert (= var1900!1 (str.++ var1900 var436)))
(assert true)
(define-const var2441 String (append/672562846 var486 ", must be integer.")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", must be integer.") 
(declare-const var486!1 String)
(assert (= var486!1 (str.++ var486 ", must be integer.")))
(assert true)
(define-const var3670 String (toString/-2075883882 var2441)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r7 
(check-sat)
; {length/-134980193=([java.lang.String], int), var396_isNumber/1050655655=([java.lang.String], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var248=org.apache.dubbo.remoting.telnet.support.command.ClearTelnetHandler, var3559=r8, var3538=org.apache.dubbo.remoting.Channel, var1367=r9, var436=r0, var3811=null_type, var1762=i2, var3154=$i0, var396=org.apache.dubbo.common.utils.StringUtils, var2639=$z0, var981=$r3, var1900=$r4, var486=$r5, var2441=$r6, var3670=$r7}
; {org.apache.dubbo.remoting.telnet.support.command.ClearTelnetHandler=var248, r8=var3559, org.apache.dubbo.remoting.Channel=var3538, r9=var1367, r0=var436, null_type=var3811, i2=var1762, $i0=var3154, org.apache.dubbo.common.utils.StringUtils=var396, $z0=var2639, $r3=var981, $r4=var1900, $r5=var486, $r6=var2441, $r7=var3670}
;seq <java.lang.String: int length()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: int length()>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r8 := @this: org.apache.dubbo.remoting.telnet.support.command.ClearTelnetHandler;	r9 := @parameter0: org.apache.dubbo.remoting.Channel;	r0 := @parameter1: java.lang.String;	i2 = 100;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	if $i0 <= 0 goto $r1 = new java.lang.StringBuilder;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>(r0);	if $z0 != 0 goto $i1 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r0);	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Illegal lines ");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", must be integer.");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	return $r7
;block_num 3