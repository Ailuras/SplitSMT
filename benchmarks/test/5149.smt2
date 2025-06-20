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

(declare-sort var2443 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(declare-fun <init>/543593434 (String Int) void)
(declare-fun getDeclaringClass/501867354 (var2443) ClassObject)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(declare-fun getName/1227988463 (var2443) String)
(declare-fun getParameterTypes/827748249 (var2443) (Array Int ClassObject))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2443 var2443)
(declare-const var1694 var2443) ; Statement: r1 := @parameter0: java.lang.reflect.Method 
(assert (not (= var1694 null-var2443)))
(define-const var2244 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/543593434 var2244 64)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(int)>(64) 

(declare-const var2244!1 String)
(declare-const var1068 Int)
(assert true)
(define-const var259 ClassObject (getDeclaringClass/501867354 var1694)) ; Statement: $r2 = virtualinvoke r1.<java.lang.reflect.Method: java.lang.Class getDeclaringClass()>() 
(assert true)
(define-const var2596 String (getName/-1958580599 var259)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getName()>() 
(assert true)
;(assert (append/672562846 var2244!1 var2596)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var2244!2 String)
(assert (= var2244!2 (str.++ var2244!1 var2596)))
(assert true)
(define-const var447 String (append/-1166366385 var2244!2 46)) ; Statement: $r5 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(46) 
(declare-const var2244!3 String)
(assert (str.prefixof var2244!2 var2244!3))
(assert true)
(define-const var3793 String (getName/1227988463 var1694)) ; Statement: $r4 = virtualinvoke r1.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
(define-const var620 String (append/672562846 var447 var3793)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var447!1 String)
(assert (= var447!1 (str.++ var447 var3793)))
(assert true)
;(assert (append/-1166366385 var620 40)) ; Statement: virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40) 
(declare-const var620!1 String)
(assert (str.prefixof var620 var620!1))
(assert true)
(define-const var2999 (Array Int ClassObject) (getParameterTypes/827748249 var1694)) ; Statement: r7 = virtualinvoke r1.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>() 
(define-const var957 Int 0) ; Statement: i1 = 0 
(define-const var707 Int (getLength-Arr-ClassObject-1 var2999)) ; Statement: i0 = lengthof r7 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(assert (>= var957 var707)) ; Cond: i1 >= i0 
(assert true)
;(assert (append/-1166366385 var2244!3 41)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(declare-const var2244!4 String)
(assert (str.prefixof var2244!3 var2244!4))
(assert true)
(define-const var751 String (toString/-2075883882 var2244!4)) ; Statement: $r8 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/543593434=([java.lang.StringBuilder, int], void), getDeclaringClass/501867354=([java.lang.reflect.Method], java.lang.Class), getName/-1958580599=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), getName/1227988463=([java.lang.reflect.Method], java.lang.String), getParameterTypes/827748249=([java.lang.reflect.Method], java.lang.Class[]), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2443=java.lang.reflect.Method, var1694=r1, var2244=$r0, var1068=64, var259=$r2, var2596=$r3, var447=$r5, var3793=$r4, var620=$r6, var2999=r7, var957=i1, var707=i0, var751=$r8}
; {java.lang.reflect.Method=var2443, r1=var1694, $r0=var2244, 64=var1068, $r2=var259, $r3=var2596, $r5=var447, $r4=var3793, $r6=var620, r7=var2999, i1=var957, i0=var707, $r8=var751}
;seq <java.lang.StringBuilder: void <init>(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: java.lang.reflect.Method;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>(int)>(64);	$r2 = virtualinvoke r1.<java.lang.reflect.Method: java.lang.Class getDeclaringClass()>();	$r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getName()>();	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r5 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(46);	$r4 = virtualinvoke r1.<java.lang.reflect.Method: java.lang.String getName()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40);	r7 = virtualinvoke r1.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>();	i1 = 0;	i0 = lengthof r7;	if i1 >= i0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	$r8 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 3