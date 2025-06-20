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

(declare-sort var2388 0)
(declare-sort var3015 0)
(declare-sort var552 0)
(declare-sort var2008 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getLength-Arr-String-1 ((Array Int String)) Int)
(declare-fun var2008_isNumber/1050655655 (String) Bool)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2388 var2388)
(declare-const null-var3015 var3015)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const null-String String)
(declare-const var576 var2388) ; Statement: r2 := @this: org.apache.dubbo.qos.command.impl.PortTelnet 
(assert (not (= var576 null-var2388)))
(declare-const var3071 var3015) ; Statement: r33 := @parameter0: org.apache.dubbo.qos.api.CommandContext 
(assert (not (= var3071 null-var3015)))
(declare-const var3561 (Array Int String)) ; Statement: r1 := @parameter1: java.lang.String[] 
(assert (not (= var3561 null-__Array__Int__String__)))
(define-const var2594 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2594)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2594!1 String)
(assert (= var2594!1 ""))
(define-const var1734 String null-String) ; Statement: r34 = null 
(define-const var379 Bool (ite (= 1 0) true false)) ; Statement: z6 = 0 
(define-const var1212 Bool (ite (= 1 0) true false)) ; Statement: z8 = 0 
(define-const var1792 Bool (ite (= 1 0) true false)) ; Statement: z7 = 0 
(define-const var3920 Int (getLength-Arr-String-1 var3561)) ; Statement: $i0 = lengthof r1 
 ; Statement: if $i0 <= 0 goto $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r34) 
(assert (not (<= var3920 0))) ; Negate: Cond: $i0 <= 0  
(define-const var3643 Int (getLength-Arr-String-1 var3561)) ; Statement: i5 = lengthof r1 
(define-const var2845 Int 0) ; Statement: i6 = 0 
(assert true) ; Non Conditional
 ; Statement: if i6 >= i5 goto $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r34) 
(assert (not (>= var2845 var3643))) ; Negate: Cond: i6 >= i5  
(define-const var442 String (select var3561 var2845)) ; Statement: r35 = r1[i6] 
(define-const var3726 String "-l") ; Statement: $r27 = "-l" 
(assert true)
(define-const var3485 Bool (= var3726 var442)) ; Statement: $z4 = virtualinvoke $r27.<java.lang.String: boolean equals(java.lang.Object)>(r35) 
 ; Statement: if $z4 == 0 goto $z5 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>(r35) 
(assert (= (ite var3485 1 0) 0)) ; Cond: $z4 == 0 
(define-const var558 Bool (var2008_isNumber/1050655655 var442)) ; Statement: $z5 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>(r35) 
 ; Statement: if $z5 != 0 goto r34 = r35 
(assert (not (not (= (ite var558 1 0) 0)))) ; Negate: Cond: $z5 != 0  
(define-const var3786 String String-init) ; Statement: $r28 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3786)) ; Statement: specialinvoke $r28.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3786!1 String)
(assert (= var3786!1 ""))
(assert true)
(define-const var3114 String (append/672562846 var3786!1 "Illegal port ")) ; Statement: $r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Illegal port ") 
(declare-const var3786!2 String)
(assert (= var3786!2 (str.++ var3786!1 "Illegal port ")))
(assert true)
(define-const var1138 String (append/672562846 var3114 var442)) ; Statement: $r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r35) 
(declare-const var3114!1 String)
(assert (= var3114!1 (str.++ var3114 var442)))
(assert true)
(define-const var2392 String (append/672562846 var1138 ", must be integer.")) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", must be integer.") 
(declare-const var1138!1 String)
(assert (= var1138!1 (str.++ var1138 ", must be integer.")))
(assert true)
(define-const var2256 String (toString/-2075883882 var2392)) ; Statement: $r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r32 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getLength-Arr-String-1=([java.lang.String[]], int), var2008_isNumber/1050655655=([java.lang.String], boolean), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2388=org.apache.dubbo.qos.command.impl.PortTelnet, var576=r2, var3015=org.apache.dubbo.qos.api.CommandContext, var3071=r33, var3561=r1, var2594=$r0, var552=null_type, var1734=r34, var379=z6, var1212=z8, var1792=z7, var3920=$i0, var3643=i5, var2845=i6, var442=r35, var3726=$r27, var3485=$z4, var2008=org.apache.dubbo.common.utils.StringUtils, var558=$z5, var3786=$r28, var3114=$r29, var1138=$r30, var2392=$r31, var2256=$r32}
; {org.apache.dubbo.qos.command.impl.PortTelnet=var2388, r2=var576, org.apache.dubbo.qos.api.CommandContext=var3015, r33=var3071, r1=var3561, $r0=var2594, null_type=var552, r34=var1734, z6=var379, z8=var1212, z7=var1792, $i0=var3920, i5=var3643, i6=var2845, r35=var442, $r27=var3726, $z4=var3485, org.apache.dubbo.common.utils.StringUtils=var2008, $z5=var558, $r28=var3786, $r29=var3114, $r30=var1138, $r31=var2392, $r32=var2256}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.String: boolean equals(java.lang.Object)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.String: boolean equals(java.lang.Object)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.qos.command.impl.PortTelnet;	r33 := @parameter0: org.apache.dubbo.qos.api.CommandContext;	r1 := @parameter1: java.lang.String[];	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	r34 = null;	z6 = 0;	z8 = 0;	z7 = 0;	$i0 = lengthof r1;	if $i0 <= 0 goto $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r34);	i5 = lengthof r1;	i6 = 0;	if i6 >= i5 goto $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r34);	r35 = r1[i6];	$r27 = "-l";	$z4 = virtualinvoke $r27.<java.lang.String: boolean equals(java.lang.Object)>(r35);	if $z4 == 0 goto $z5 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>(r35);	$z5 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>(r35);	if $z5 != 0 goto r34 = r35;	$r28 = new java.lang.StringBuilder;	specialinvoke $r28.<java.lang.StringBuilder: void <init>()>();	$r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Illegal port ");	$r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r35);	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", must be integer.");	$r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.String toString()>();	return $r32
;block_num 6