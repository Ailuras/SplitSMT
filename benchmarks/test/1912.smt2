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

(declare-sort var1446 0)
(declare-sort var2749 0)
(declare-sort var70 0)
(declare-sort var2822 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var1446_modifier/746398253 (Int) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(declare-fun var70_getName/715767591 (ClassObject) String)
(declare-fun var2822_isNotEmpty/-1251449450 (String) Bool)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun addField/-942024929 (var1446 String) var1446)
(declare-const null-var1446 var1446)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const null-ClassObject ClassObject)
(declare-const var133 var1446) ; Statement: r9 := @this: org.apache.dubbo.common.bytecode.ClassGenerator 
(assert (not (= var133 null-var1446)))
(declare-const var3874 String) ; Statement: r7 := @parameter0: java.lang.String 
(assert (not (= var3874 null-String)))
(declare-const var3158 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var3158 null-Int)))
(declare-const var3675 ClassObject) ; Statement: r3 := @parameter2: java.lang.Class 
(assert (not (= var3675 null-ClassObject)))
(declare-const var3670 String) ; Statement: r8 := @parameter3: java.lang.String 
(assert (not (= var3670 null-String)))
(define-const var3575 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3575)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3575!1 String)
(assert (= var3575!1 ""))
(define-const var2687 String (var1446_modifier/746398253 var3158)) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.bytecode.ClassGenerator: java.lang.String modifier(int)>(i0) 
(assert true)
(define-const var939 String (append/672562846 var3575!1 var2687)) ; Statement: $r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r1) 
(declare-const var3575!2 String)
(assert (= var3575!2 (str.++ var3575!1 var2687)))
(assert true)
(define-const var899 String (append/-1166366385 var939 32)) ; Statement: $r5 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(declare-const var939!1 String)
(assert (str.prefixof var939 var939!1))
(define-const var3024 String (var70_getName/715767591 var3675)) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getName(java.lang.Class)>(r3) 
(assert true)
(define-const var3907 String (append/672562846 var899 var3024)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var899!1 String)
(assert (= var899!1 (str.++ var899 var3024)))
(assert true)
;(assert (append/-1166366385 var3907 32)) ; Statement: virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(declare-const var3907!1 String)
(assert (str.prefixof var3907 var3907!1))
(assert true)
;(assert (append/672562846 var3575!2 var3874)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r7) 
(declare-const var3575!3 String)
(assert (= var3575!3 (str.++ var3575!2 var3874)))
(define-const var690 Bool (var2822_isNotEmpty/-1251449450 var3670)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r8) 
 ; Statement: if $z0 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(59) 
(assert (= (ite var690 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
;(assert (append/-1166366385 var3575!3 59)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(59) 
(declare-const var3575!4 String)
(assert (str.prefixof var3575!3 var3575!4))
(assert true)
(define-const var2596 String (toString/-2075883882 var3575!4)) ; Statement: $r10 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
(define-const var2904 var1446 (addField/-942024929 var133 var2596)) ; Statement: $r11 = virtualinvoke r9.<org.apache.dubbo.common.bytecode.ClassGenerator: org.apache.dubbo.common.bytecode.ClassGenerator addField(java.lang.String)>($r10) 
 ; Statement: return $r11 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var1446_modifier/746398253=([int], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), var70_getName/715767591=([java.lang.Class], java.lang.String), var2822_isNotEmpty/-1251449450=([java.lang.String], boolean), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), addField/-942024929=([org.apache.dubbo.common.bytecode.ClassGenerator, java.lang.String], org.apache.dubbo.common.bytecode.ClassGenerator)}
; {var1446=org.apache.dubbo.common.bytecode.ClassGenerator, var133=r9, var3874=r7, var2749=null_type, var3158=i0, var3675=r3, var3670=r8, var3575=$r0, var2687=$r1, var939=$r2, var899=$r5, var70=org.apache.dubbo.common.utils.ReflectUtils, var3024=$r4, var3907=$r6, var2822=org.apache.dubbo.common.utils.StringUtils, var690=$z0, var2596=$r10, var2904=$r11}
; {org.apache.dubbo.common.bytecode.ClassGenerator=var1446, r9=var133, r7=var3874, null_type=var2749, i0=var3158, r3=var3675, r8=var3670, $r0=var3575, $r1=var2687, $r2=var939, $r5=var899, org.apache.dubbo.common.utils.ReflectUtils=var70, $r4=var3024, $r6=var3907, org.apache.dubbo.common.utils.StringUtils=var2822, $z0=var690, $r10=var2596, $r11=var2904}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 3,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r9 := @this: org.apache.dubbo.common.bytecode.ClassGenerator;	r7 := @parameter0: java.lang.String;	i0 := @parameter1: int;	r3 := @parameter2: java.lang.Class;	r8 := @parameter3: java.lang.String;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r1 = staticinvoke <org.apache.dubbo.common.bytecode.ClassGenerator: java.lang.String modifier(int)>(i0);	$r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r1);	$r5 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	$r4 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getName(java.lang.Class)>(r3);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r7);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r8);	if $z0 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(59);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(59);	$r10 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r11 = virtualinvoke r9.<org.apache.dubbo.common.bytecode.ClassGenerator: org.apache.dubbo.common.bytecode.ClassGenerator addField(java.lang.String)>($r10);	return $r11
;block_num 2