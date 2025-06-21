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

(declare-sort var2053 0)
(declare-sort var3370 0)
(declare-sort var1401 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-ClassObject-init () (Array Int ClassObject))
(declare-fun getDeclaredConstructors/118869227 (ClassObject) (Array Int var3370))
(declare-fun getLength-Arr-var3370-1 ((Array Int var3370)) Int)
(declare-fun var1401-init () var1401)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1084991535 (var1401 String) void)
(declare-const null-ClassObject ClassObject)
(declare-const null-var2053 var2053)
(declare-const var730 ClassObject) ; Statement: r0 := @parameter0: java.lang.Class 
(assert (not (= var730 null-ClassObject)))
(define-const var2878 (Array Int ClassObject) arr-ClassObject-init) ; Statement: $r1 = newarray (java.lang.Class)[0] 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2891 var2053) ; Statement: $r14 := @caughtexception 
(assert (not (= var2891 null-var2053)))
(assert true)
(define-const var2837 (Array Int var3370) (getDeclaredConstructors/118869227 var730)) ; Statement: r15 = virtualinvoke r0.<java.lang.Class: java.lang.reflect.Constructor[] getDeclaredConstructors()>() 
(define-const var2795 Int (getLength-Arr-var3370-1 var2837)) ; Statement: $i1 = lengthof r15 
 ; Statement: if $i1 != 0 goto r24 = null 
(assert (not (not (= var2795 0)))) ; Negate: Cond: $i1 != 0  
(define-const var3123 var1401 var1401-init) ; Statement: $r18 = new java.lang.RuntimeException 
(define-const var1015 String String-init) ; Statement: $r19 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1015)) ; Statement: specialinvoke $r19.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1015!1 String)
(assert (= var1015!1 ""))
(assert true)
(define-const var1847 String (append/672562846 var1015!1 "Illegal constructor: ")) ; Statement: $r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Illegal constructor: ") 
(declare-const var1015!2 String)
(assert (= var1015!2 (str.++ var1015!1 "Illegal constructor: ")))
(assert true)
(define-const var2288 String (getName/-1958580599 var730)) ; Statement: $r20 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var2174 String (append/672562846 var1847 var2288)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r20) 
(declare-const var1847!1 String)
(assert (= var1847!1 (str.++ var1847 var2288)))
(assert true)
(define-const var918 String (toString/-2075883882 var2174)) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1084991535 var3123 var918)) ; Statement: specialinvoke $r18.<java.lang.RuntimeException: void <init>(java.lang.String)>($r23) 

(declare-const var3123!1 var1401)
(declare-const var918!1 String)
 ; Statement: throw $r18 
(check-sat)
; {arr-ClassObject-init=([], java.lang.Class[]), getDeclaredConstructors/118869227=([java.lang.Class], java.lang.reflect.Constructor[]), getLength-Arr-var3370-1=([java.lang.reflect.Constructor[]], int), var1401-init=([], java.lang.RuntimeException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getName/-1958580599=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1084991535=([java.lang.RuntimeException, java.lang.String], void)}
; {var730=r0, var2878=$r1, var2053=java.lang.Exception, var2891=$r14, var3370=java.lang.reflect.Constructor, var2837=r15, var2795=$i1, var1401=java.lang.RuntimeException, var3123=$r18, var1015=$r19, var1847=$r21, var2288=$r20, var2174=$r22, var918=$r23}
; {r0=var730, $r1=var2878, java.lang.Exception=var2053, $r14=var2891, java.lang.reflect.Constructor=var3370, r15=var2837, $i1=var2795, java.lang.RuntimeException=var1401, $r18=var3123, $r19=var1015, $r21=var1847, $r20=var2288, $r22=var2174, $r23=var918}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.Class;	$r1 = newarray (java.lang.Class)[0];	$r14 := @caughtexception;	r15 = virtualinvoke r0.<java.lang.Class: java.lang.reflect.Constructor[] getDeclaredConstructors()>();	$i1 = lengthof r15;	if $i1 != 0 goto r24 = null;	$r18 = new java.lang.RuntimeException;	$r19 = new java.lang.StringBuilder;	specialinvoke $r19.<java.lang.StringBuilder: void <init>()>();	$r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Illegal constructor: ");	$r20 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>();	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r20);	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r18.<java.lang.RuntimeException: void <init>(java.lang.String)>($r23);	throw $r18
;block_num 3