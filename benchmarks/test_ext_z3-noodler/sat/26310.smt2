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

(declare-sort var2700 0)
(declare-sort var2762 0)
(declare-sort var2660 0)
(declare-sort var1715 0)
(declare-sort var397 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getConstructors/-1160885883 (ClassObject) (Array Int var2660))
(declare-fun getLength-Arr-var2660-1 ((Array Int var2660)) Int)
(declare-fun var1715-init () var1715)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var397) String)
(declare-fun cast-from-ClassObject-to-var397 (ClassObject) var397)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var1715 String) void)
(declare-const null-var2700 var2700)
(declare-const null-String String)
(declare-const null-ClassObject ClassObject)
(declare-const null-var2660 var2660)
(declare-const var1680 var2700) ; Statement: r4 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.util.RestToolKit 
(assert (not (= var1680 null-var2700)))
(declare-const var3300 String) ; Statement: r5 := @parameter1: java.lang.String 
(assert (not (= var3300 null-String)))
(declare-const var3776 ClassObject) ; Statement: r0 := @parameter2: java.lang.Class 
(assert (not (= var3776 null-ClassObject)))
(assert true)
(define-const var1563 (Array Int var2660) (getConstructors/-1160885883 var3776)) ; Statement: r1 = virtualinvoke r0.<java.lang.Class: java.lang.reflect.Constructor[] getConstructors()>() 
(define-const var2516 var2660 null-var2660) ; Statement: r12 = null 
(define-const var1745 Int (getLength-Arr-var2660-1 var1563)) ; Statement: $i0 = lengthof r1 
 ; Statement: if $i0 != 1 goto $r2 = newarray (java.lang.Class)[0] 
(assert (not (not (= var1745 1)))) ; Negate: Cond: $i0 != 1  
(define-const var2516!1 var2660 (select var1563 0)) ; Statement: r12 = r1[0] 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if r12 != null goto $r3 = new org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$ConstructorMeta 
(assert (not (not (= var2516!1 null-var2660)))) ; Negate: Cond: r12 != null  
(define-const var2116 var1715 var1715-init) ; Statement: $r6 = new java.lang.IllegalArgumentException 
(define-const var2508 String String-init) ; Statement: $r7 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2508)) ; Statement: specialinvoke $r7.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2508!1 String)
(assert (= var2508!1 ""))
(assert true)
(define-const var454 String (append/672562846 var2508!1 "No available default constructor found in ")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No available default constructor found in ") 
(declare-const var2508!2 String)
(assert (= var2508!2 (str.++ var2508!1 "No available default constructor found in ")))
(assert true)
(define-const var3212 String (append/-1031950772 var454 (cast-from-ClassObject-to-var397 var3776))) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0) 
(declare-const var454!1 String)
(assert (str.prefixof var454 var454!1))
(assert true)
(define-const var2568 String (toString/-2075883882 var3212)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var2116 var2568)) ; Statement: specialinvoke $r6.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r10) 

(declare-const var2116!1 var1715)
(declare-const var2568!1 String)
 ; Statement: throw $r6 
(check-sat)
; {getConstructors/-1160885883=([java.lang.Class], java.lang.reflect.Constructor[]), getLength-Arr-var2660-1=([java.lang.reflect.Constructor[]], int), var1715-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var397=([java.lang.Class], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var2700=org.apache.dubbo.rpc.protocol.tri.rest.util.RestToolKit, var1680=r4, var3300=r5, var2762=null_type, var3776=r0, var2660=java.lang.reflect.Constructor, var1563=r1, var2516=r12, var1745=$i0, var1715=java.lang.IllegalArgumentException, var2116=$r6, var2508=$r7, var454=$r8, var397=java.lang.Object, var3212=$r9, var2568=$r10}
; {org.apache.dubbo.rpc.protocol.tri.rest.util.RestToolKit=var2700, r4=var1680, r5=var3300, null_type=var2762, r0=var3776, java.lang.reflect.Constructor=var2660, r1=var1563, r12=var2516, $i0=var1745, java.lang.IllegalArgumentException=var1715, $r6=var2116, $r7=var2508, $r8=var454, java.lang.Object=var397, $r9=var3212, $r10=var2568}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r4 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.util.RestToolKit;	r5 := @parameter1: java.lang.String;	r0 := @parameter2: java.lang.Class;	r1 = virtualinvoke r0.<java.lang.Class: java.lang.reflect.Constructor[] getConstructors()>();	r12 = null;	$i0 = lengthof r1;	if $i0 != 1 goto $r2 = newarray (java.lang.Class)[0];	r12 = r1[0];	goto [?= (branch)];	if r12 != null goto $r3 = new org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$ConstructorMeta;	$r6 = new java.lang.IllegalArgumentException;	$r7 = new java.lang.StringBuilder;	specialinvoke $r7.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No available default constructor found in ");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r6.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r10);	throw $r6
;block_num 4