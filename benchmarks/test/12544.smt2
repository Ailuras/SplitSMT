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

(declare-sort var1591 0)
(declare-sort var3627 0)
(declare-sort var3558 0)
(declare-sort var1898 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getLength-Arr-String-1 ((Array Int String)) Int)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var3558_toString/-575966009 ((Array Int var1898)) String)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var1898__ ((Array Int String)) (Array Int var1898))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1591 var1591)
(declare-const null-var3627 var3627)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var1320 var1591) ; Statement: r15 := @this: org.apache.dubbo.qos.command.impl.PwdTelnet 
(assert (not (= var1320 null-var1591)))
(declare-const var1812 var3627) ; Statement: r1 := @parameter0: org.apache.dubbo.qos.api.CommandContext 
(assert (not (= var1812 null-var3627)))
(declare-const var815 (Array Int String)) ; Statement: r0 := @parameter1: java.lang.String[] 
(assert (not (= var815 null-__Array__Int__String__)))
(define-const var2696 Int (getLength-Arr-String-1 var815)) ; Statement: $i0 = lengthof r0 
 ; Statement: if $i0 <= 0 goto $r3 = virtualinvoke r1.<org.apache.dubbo.qos.api.CommandContext: io.netty.channel.Channel getRemote()>() 
(assert (not (<= var2696 0))) ; Negate: Cond: $i0 <= 0  
(define-const var872 String String-init) ; Statement: $r9 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var872)) ; Statement: specialinvoke $r9.<java.lang.StringBuilder: void <init>()>() 
(declare-const var872!1 String)
(assert (= var872!1 ""))
(assert true)
(define-const var1503 String (append/672562846 var872!1 "Unsupported parameter ")) ; Statement: $r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unsupported parameter ") 
(declare-const var872!2 String)
(assert (= var872!2 (str.++ var872!1 "Unsupported parameter ")))
(define-const var1326 String (var3558_toString/-575966009 (cast-from-__Array__Int__String__-to-__Array__Int__var1898__ var815))) ; Statement: $r10 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>(r0) 
(assert true)
(define-const var3778 String (append/672562846 var1503 var1326)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10) 
(declare-const var1503!1 String)
(assert (= var1503!1 (str.++ var1503 var1326)))
(assert true)
(define-const var1796 String (append/672562846 var3778 " for pwd.")) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" for pwd.") 
(declare-const var3778!1 String)
(assert (= var3778!1 (str.++ var3778 " for pwd.")))
(assert true)
(define-const var3874 String (toString/-2075883882 var1796)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r14 
(check-sat)
; {getLength-Arr-String-1=([java.lang.String[]], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var3558_toString/-575966009=([java.lang.Object[]], java.lang.String), cast-from-__Array__Int__String__-to-__Array__Int__var1898__=([java.lang.String[]], java.lang.Object[]), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1591=org.apache.dubbo.qos.command.impl.PwdTelnet, var1320=r15, var3627=org.apache.dubbo.qos.api.CommandContext, var1812=r1, var815=r0, var2696=$i0, var872=$r9, var1503=$r11, var3558=java.util.Arrays, var1898=java.lang.Object, var1326=$r10, var3778=$r12, var1796=$r13, var3874=$r14}
; {org.apache.dubbo.qos.command.impl.PwdTelnet=var1591, r15=var1320, org.apache.dubbo.qos.api.CommandContext=var3627, r1=var1812, r0=var815, $i0=var2696, $r9=var872, $r11=var1503, java.util.Arrays=var3558, java.lang.Object=var1898, $r10=var1326, $r12=var3778, $r13=var1796, $r14=var3874}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.util.Arrays: java.lang.String toString(java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r15 := @this: org.apache.dubbo.qos.command.impl.PwdTelnet;	r1 := @parameter0: org.apache.dubbo.qos.api.CommandContext;	r0 := @parameter1: java.lang.String[];	$i0 = lengthof r0;	if $i0 <= 0 goto $r3 = virtualinvoke r1.<org.apache.dubbo.qos.api.CommandContext: io.netty.channel.Channel getRemote()>();	$r9 = new java.lang.StringBuilder;	specialinvoke $r9.<java.lang.StringBuilder: void <init>()>();	$r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unsupported parameter ");	$r10 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>(r0);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" for pwd.");	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	return $r14
;block_num 2