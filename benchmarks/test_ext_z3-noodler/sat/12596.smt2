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
(declare-sort var1201 0)
(declare-sort var1124 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun commandHelper/1675652781 (var1591) var1124)
(declare-fun hasCommand/-420018880 (var1124 String) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1591 var1591)
(declare-const null-String String)
(declare-const var846 var1591) ; Statement: r0 := @this: org.apache.dubbo.qos.command.impl.Help 
(assert (not (= var846 null-var1591)))
(declare-const var819 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var819 null-String)))
(define-const var3019 var1124 (commandHelper/1675652781 var846)) ; Statement: $r2 = r0.<org.apache.dubbo.qos.command.impl.Help: org.apache.dubbo.qos.command.util.CommandHelper commandHelper> 
(assert true)
(define-const var1196 Bool (hasCommand/-420018880 var3019 var819)) ; Statement: $z0 = virtualinvoke $r2.<org.apache.dubbo.qos.command.util.CommandHelper: boolean hasCommand(java.lang.String)>(r1) 
 ; Statement: if $z0 != 0 goto $r3 = r0.<org.apache.dubbo.qos.command.impl.Help: org.apache.dubbo.qos.command.util.CommandHelper commandHelper> 
(assert (not (not (= (ite var1196 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var3474 String String-init) ; Statement: $r19 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3474)) ; Statement: specialinvoke $r19.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3474!1 String)
(assert (= var3474!1 ""))
(assert true)
(define-const var1531 String (append/672562846 var3474!1 "no such command:")) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("no such command:") 
(declare-const var3474!2 String)
(assert (= var3474!2 (str.++ var3474!1 "no such command:")))
(assert true)
(define-const var3733 String (append/672562846 var1531 var819)) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var1531!1 String)
(assert (= var1531!1 (str.++ var1531 var819)))
(assert true)
(define-const var2966 String (toString/-2075883882 var3733)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r22 
(check-sat)
; {commandHelper/1675652781=([org.apache.dubbo.qos.command.impl.Help], org.apache.dubbo.qos.command.util.CommandHelper), hasCommand/-420018880=([org.apache.dubbo.qos.command.util.CommandHelper, java.lang.String], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1591=org.apache.dubbo.qos.command.impl.Help, var846=r0, var819=r1, var1201=null_type, var1124=org.apache.dubbo.qos.command.util.CommandHelper, var3019=$r2, var1196=$z0, var3474=$r19, var1531=$r20, var3733=$r21, var2966=$r22}
; {org.apache.dubbo.qos.command.impl.Help=var1591, r0=var846, r1=var819, null_type=var1201, org.apache.dubbo.qos.command.util.CommandHelper=var1124, $r2=var3019, $z0=var1196, $r19=var3474, $r20=var1531, $r21=var3733, $r22=var2966}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.qos.command.impl.Help;	r1 := @parameter0: java.lang.String;	$r2 = r0.<org.apache.dubbo.qos.command.impl.Help: org.apache.dubbo.qos.command.util.CommandHelper commandHelper>;	$z0 = virtualinvoke $r2.<org.apache.dubbo.qos.command.util.CommandHelper: boolean hasCommand(java.lang.String)>(r1);	if $z0 != 0 goto $r3 = r0.<org.apache.dubbo.qos.command.impl.Help: org.apache.dubbo.qos.command.util.CommandHelper commandHelper>;	$r19 = new java.lang.StringBuilder;	specialinvoke $r19.<java.lang.StringBuilder: void <init>()>();	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("no such command:");	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.String toString()>();	return $r22
;block_num 2