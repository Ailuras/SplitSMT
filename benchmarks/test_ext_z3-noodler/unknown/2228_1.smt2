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

(declare-sort var3494 0)
(declare-sort var895 0)
(declare-sort var3365 0)
(declare-sort var2847 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var3494_modifier/746398253 (Int) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(declare-fun var3365_isNotEmpty/-1514399294 ((Array Int var2847)) Bool)
(declare-fun cast-from-__Array__Int__ClassObject__-to-__Array__Int__var2847__ ((Array Int ClassObject)) (Array Int var2847))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun addConstructor/1313030879 (var3494 String) var3494)
(declare-const null-var3494 var3494)
(declare-const null-Int Int)
(declare-const null-__Array__Int__ClassObject__ (Array Int ClassObject))
(declare-const null-String String)
(declare-const var879 var3494) ; Statement: r9 := @this: org.apache.dubbo.common.bytecode.ClassGenerator 
(assert (not (= var879 null-var3494)))
(declare-const var3039 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var3039 null-Int)))
(declare-const var2517 (Array Int ClassObject)) ; Statement: r4 := @parameter1: java.lang.Class[] 
(assert (not (= var2517 null-__Array__Int__ClassObject__)))
(declare-const var1972 (Array Int ClassObject)) ; Statement: r5 := @parameter2: java.lang.Class[] 
(assert (not (= var1972 null-__Array__Int__ClassObject__)))
(declare-const var746 String) ; Statement: r6 := @parameter3: java.lang.String 
(assert (not (= var746 null-String)))
(define-const var1695 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1695)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1695!1 String)
(assert (= var1695!1 ""))
(define-const var1374 String (var3494_modifier/746398253 var3039)) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.bytecode.ClassGenerator: java.lang.String modifier(int)>(i0) 
(assert true)
(define-const var2215 String (append/672562846 var1695!1 var1374)) ; Statement: $r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r1) 
(declare-const var1695!2 String)
(assert (= var1695!2 (str.++ var1695!1 var1374)))
(assert true)
(define-const var2236 String (append/-1166366385 var2215 32)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(declare-const var2215!1 String)
(assert (str.prefixof var2215 var2215!1))
(assert true)
;(assert (append/672562846 var2236 "<init>")) ; Statement: virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("<init>") 
(declare-const var2236!1 String)
(assert (= var2236!1 (str.++ var2236 "<init>")))
(assert true)
;(assert (append/-1166366385 var1695!2 40)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40) 
(declare-const var1695!3 String)
(assert (str.prefixof var1695!2 var1695!3))
(define-const var3014 Int 0) ; Statement: i3 = 0 
(assert true) ; Non Conditional
(define-const var3756 Int (getLength-Arr-ClassObject-1 var2517)) ; Statement: $i1 = lengthof r4 
 ; Statement: if i3 >= $i1 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(assert (>= var3014 var3756)) ; Cond: i3 >= $i1 
(assert true)
;(assert (append/-1166366385 var1695!3 41)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(declare-const var1695!4 String)
(assert (str.prefixof var1695!3 var1695!4))
(define-const var3626 Bool (var3365_isNotEmpty/-1514399294 (cast-from-__Array__Int__ClassObject__-to-__Array__Int__var2847__ var1972))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.ArrayUtils: boolean isNotEmpty(java.lang.Object[])>(r5) 
 ; Statement: if $z0 == 0 goto $r7 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(123) 
(assert (= (ite var3626 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3157 String (append/-1166366385 var1695!4 123)) ; Statement: $r7 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(123) 
(declare-const var1695!5 String)
(assert (str.prefixof var1695!4 var1695!5))
(assert true)
(define-const var3666 String (append/672562846 var3157 var746)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r6) 
(declare-const var3157!1 String)
(assert (= var3157!1 (str.++ var3157 var746)))
(assert true)
;(assert (append/-1166366385 var3666 125)) ; Statement: virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var3666!1 String)
(assert (str.prefixof var3666 var3666!1))
(assert true)
(define-const var3639 String (toString/-2075883882 var1695!5)) ; Statement: $r10 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
(define-const var2696 var3494 (addConstructor/1313030879 var879 var3639)) ; Statement: $r11 = virtualinvoke r9.<org.apache.dubbo.common.bytecode.ClassGenerator: org.apache.dubbo.common.bytecode.ClassGenerator addConstructor(java.lang.String)>($r10) 
 ; Statement: return $r11 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var3494_modifier/746398253=([int], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), var3365_isNotEmpty/-1514399294=([java.lang.Object[]], boolean), cast-from-__Array__Int__ClassObject__-to-__Array__Int__var2847__=([java.lang.Class[]], java.lang.Object[]), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), addConstructor/1313030879=([org.apache.dubbo.common.bytecode.ClassGenerator, java.lang.String], org.apache.dubbo.common.bytecode.ClassGenerator)}
; {var3494=org.apache.dubbo.common.bytecode.ClassGenerator, var879=r9, var3039=i0, var2517=r4, var1972=r5, var746=r6, var895=null_type, var1695=$r0, var1374=$r1, var2215=$r2, var2236=$r3, var3014=i3, var3756=$i1, var3365=org.apache.dubbo.common.utils.ArrayUtils, var2847=java.lang.Object, var3626=$z0, var3157=$r7, var3666=$r8, var3639=$r10, var2696=$r11}
; {org.apache.dubbo.common.bytecode.ClassGenerator=var3494, r9=var879, i0=var3039, r4=var2517, r5=var1972, r6=var746, null_type=var895, $r0=var1695, $r1=var1374, $r2=var2215, $r3=var2236, i3=var3014, $i1=var3756, org.apache.dubbo.common.utils.ArrayUtils=var3365, java.lang.Object=var2847, $z0=var3626, $r7=var3157, $r8=var3666, $r10=var3639, $r11=var2696}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 5,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r9 := @this: org.apache.dubbo.common.bytecode.ClassGenerator;	i0 := @parameter0: int;	r4 := @parameter1: java.lang.Class[];	r5 := @parameter2: java.lang.Class[];	r6 := @parameter3: java.lang.String;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r1 = staticinvoke <org.apache.dubbo.common.bytecode.ClassGenerator: java.lang.String modifier(int)>(i0);	$r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r1);	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("<init>");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40);	i3 = 0;	$i1 = lengthof r4;	if i3 >= $i1 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	$z0 = staticinvoke <org.apache.dubbo.common.utils.ArrayUtils: boolean isNotEmpty(java.lang.Object[])>(r5);	if $z0 == 0 goto $r7 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(123);	$r7 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(123);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r6);	virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r10 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r11 = virtualinvoke r9.<org.apache.dubbo.common.bytecode.ClassGenerator: org.apache.dubbo.common.bytecode.ClassGenerator addConstructor(java.lang.String)>($r10);	return $r11
;block_num 4