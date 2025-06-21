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

(declare-sort var3009 0)
(declare-sort var1862 0)
(declare-sort var1417 0)
(declare-sort var1669 0)
(declare-sort var3696 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun clazz/105774719 (var3009) ClassObject)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var3009_toUpperMethodName/555655841 (String) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun methodClassMap/105774719 (var3009) var1417)
(declare-fun var1417_get/1088891777 (var1417 var1669) var1669)
(declare-fun cast-from-String-to-var1669 (String) var1669)
(declare-fun cast-from-var1669-to-ClassObject (var1669) ClassObject)
(declare-fun var1417_put/1464166817 (var1417 var1669 var1669) var1669)
(declare-fun cast-from-ClassObject-to-var1669 (ClassObject) var1669)
(declare-const null-var3009 var3009)
(declare-const null-String String)
(declare-const null-ClassObject ClassObject)
(declare-const null-var3696 var3696)
(declare-const var2909 var3009) ; Statement: r1 := @this: org.apache.dubbo.validation.support.jvalidation.JValidatorNew 
(assert (not (= var2909 null-var3009)))
(declare-const var2778 String) ; Statement: r5 := @parameter0: java.lang.String 
(assert (not (= var2778 null-String)))
(define-const var940 ClassObject null-ClassObject) ; Statement: r20 = null 
(define-const var2710 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2710)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2710!1 String)
(assert (= var2710!1 ""))
(define-const var3523 ClassObject (clazz/105774719 var2909)) ; Statement: $r2 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class clazz> 
(assert true)
(define-const var1696 String (getName/-1958580599 var3523)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var3832 String (append/672562846 var2710!1 var1696)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var2710!2 String)
(assert (= var2710!2 (str.++ var2710!1 var1696)))
(assert true)
(define-const var397 String (append/672562846 var3832 "$")) ; Statement: $r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("$") 
(declare-const var3832!1 String)
(assert (= var3832!1 (str.++ var3832 "$")))
(define-const var491 String (var3009_toUpperMethodName/555655841 var2778)) ; Statement: $r6 = staticinvoke <org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.String toUpperMethodName(java.lang.String)>(r5) 
(assert true)
(define-const var888 String (append/672562846 var397 var491)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var397!1 String)
(assert (= var397!1 (str.++ var397 var491)))
(assert true)
(define-const var3677 String (toString/-2075883882 var888)) ; Statement: r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var3122 var1417 (methodClassMap/105774719 var2909)) ; Statement: $r10 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.util.Map methodClassMap> 
(define-const var116 var1669 (var1417_get/1088891777 var3122 (cast-from-String-to-var1669 var3677))) ; Statement: $r11 = interfaceinvoke $r10.<java.util.Map: java.lang.Object get(java.lang.Object)>(r9) 
(define-const var2705 ClassObject (cast-from-var1669-to-ClassObject var116)) ; Statement: r12 = (java.lang.Class) $r11 
 ; Statement: if r12 == null goto $r13 = staticinvoke <java.lang.Thread: java.lang.Thread currentThread()>() 
(assert (not (= var2705 null-ClassObject))) ; Negate: Cond: r12 == null  
(declare-const var3842 var3696) ; Statement: $r17 := @caughtexception 
(assert (not (= var3842 null-var3696)))
(define-const var3206 var1417 (methodClassMap/105774719 var2909)) ; Statement: $r19 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.util.Map methodClassMap> 
(define-const var1528 ClassObject (clazz/105774719 var2909)) ; Statement: $r18 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class clazz> 
;(assert (var1417_put/1464166817 var3206 (cast-from-String-to-var1669 var3677) (cast-from-ClassObject-to-var1669 var1528))) ; Statement: interfaceinvoke $r19.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r9, $r18) 

(declare-const var3206!1 var1417)
(declare-const var3677!1 String)
(declare-const var1528!1 ClassObject)
(assert true) ; Non Conditional
 ; Statement: return r20 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), clazz/105774719=([org.apache.dubbo.validation.support.jvalidation.JValidatorNew], java.lang.Class), getName/-1958580599=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var3009_toUpperMethodName/555655841=([java.lang.String], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), methodClassMap/105774719=([org.apache.dubbo.validation.support.jvalidation.JValidatorNew], java.util.Map), var1417_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var1669=([java.lang.String], java.lang.Object), cast-from-var1669-to-ClassObject=([java.lang.Object], java.lang.Class), var1417_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-ClassObject-to-var1669=([java.lang.Class], java.lang.Object)}
; {var3009=org.apache.dubbo.validation.support.jvalidation.JValidatorNew, var2909=r1, var2778=r5, var1862=null_type, var940=r20, var2710=$r0, var3523=$r2, var1696=$r3, var3832=$r4, var397=$r7, var491=$r6, var888=$r8, var3677=r9, var1417=java.util.Map, var3122=$r10, var1669=java.lang.Object, var116=$r11, var2705=r12, var3696=java.lang.ClassNotFoundException, var3842=$r17, var3206=$r19, var1528=$r18}
; {org.apache.dubbo.validation.support.jvalidation.JValidatorNew=var3009, r1=var2909, r5=var2778, null_type=var1862, r20=var940, $r0=var2710, $r2=var3523, $r3=var1696, $r4=var3832, $r7=var397, $r6=var491, $r8=var888, r9=var3677, java.util.Map=var1417, $r10=var3122, java.lang.Object=var1669, $r11=var116, r12=var2705, java.lang.ClassNotFoundException=var3696, $r17=var3842, $r19=var3206, $r18=var1528}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.validation.support.jvalidation.JValidatorNew;	r5 := @parameter0: java.lang.String;	r20 = null;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class clazz>;	$r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getName()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("$");	$r6 = staticinvoke <org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.String toUpperMethodName(java.lang.String)>(r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	$r10 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.util.Map methodClassMap>;	$r11 = interfaceinvoke $r10.<java.util.Map: java.lang.Object get(java.lang.Object)>(r9);	r12 = (java.lang.Class) $r11;	if r12 == null goto $r13 = staticinvoke <java.lang.Thread: java.lang.Thread currentThread()>();	$r17 := @caughtexception;	$r19 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.util.Map methodClassMap>;	$r18 = r1.<org.apache.dubbo.validation.support.jvalidation.JValidatorNew: java.lang.Class clazz>;	interfaceinvoke $r19.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r9, $r18);	return r20
;block_num 3