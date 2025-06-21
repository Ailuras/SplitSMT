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

(declare-sort var1340 0)
(declare-sort var893 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(declare-fun getName/1227988463 (var1340) String)
(define-fun <init>/-1061048412 ((s String)) String s)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun getParameterTypes/827748249 (var1340) (Array Int ClassObject))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(declare-fun getReturnType/-1494237887 (var1340) ClassObject)
(declare-fun var893_getDesc/-297103955 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1340 var1340)
(declare-const var3368 var1340) ; Statement: r1 := @parameter0: java.lang.reflect.Method 
(assert (not (= var3368 null-var1340)))
(define-const var1924 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
(define-const var544 String (getName/1227988463 var3368)) ; Statement: $r2 = virtualinvoke r1.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
;(assert (<init>/-1061048412 var1924 var544)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>($r2) 
(declare-const var1924!1 String)
(assert (= var1924!1 var544))
(assert true)
(define-const var1357 String (append/-1166366385 var1924!1 40)) ; Statement: r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40) 
(declare-const var1924!2 String)
(assert (str.prefixof var1924!1 var1924!2))
(assert true)
(define-const var2433 (Array Int ClassObject) (getParameterTypes/827748249 var3368)) ; Statement: r4 = virtualinvoke r1.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>() 
(define-const var217 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
(define-const var2461 Int (getLength-Arr-ClassObject-1 var2433)) ; Statement: $i0 = lengthof r4 
 ; Statement: if i1 >= $i0 goto $r7 = virtualinvoke r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(assert (>= var217 var2461)) ; Cond: i1 >= $i0 
(assert true)
(define-const var209 String (append/-1166366385 var1357 41)) ; Statement: $r7 = virtualinvoke r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(declare-const var1357!1 String)
(assert (str.prefixof var1357 var1357!1))
(assert true)
(define-const var1122 ClassObject (getReturnType/-1494237887 var3368)) ; Statement: $r5 = virtualinvoke r1.<java.lang.reflect.Method: java.lang.Class getReturnType()>() 
(define-const var3483 String (var893_getDesc/-297103955 var1122)) ; Statement: $r6 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getDesc(java.lang.Class)>($r5) 
(assert true)
;(assert (append/672562846 var209 var3483)) ; Statement: virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var209!1 String)
(assert (= var209!1 (str.++ var209 var3483)))
(assert true)
(define-const var370 String (toString/-2075883882 var1357!1)) ; Statement: $r8 = virtualinvoke r3.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {String-init=([], java.lang.StringBuilder), getName/1227988463=([java.lang.reflect.Method], java.lang.String), <init>/-1061048412=([java.lang.StringBuilder, java.lang.String], void), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), getParameterTypes/827748249=([java.lang.reflect.Method], java.lang.Class[]), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), getReturnType/-1494237887=([java.lang.reflect.Method], java.lang.Class), var893_getDesc/-297103955=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1340=java.lang.reflect.Method, var3368=r1, var1924=$r0, var544=$r2, var1357=r3, var2433=r4, var217=i1, var2461=$i0, var209=$r7, var1122=$r5, var893=org.apache.dubbo.common.utils.ReflectUtils, var3483=$r6, var370=$r8}
; {java.lang.reflect.Method=var1340, r1=var3368, $r0=var1924, $r2=var544, r3=var1357, r4=var2433, i1=var217, $i0=var2461, $r7=var209, $r5=var1122, org.apache.dubbo.common.utils.ReflectUtils=var893, $r6=var3483, $r8=var370}
;seq <java.lang.StringBuilder: void <init>(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: java.lang.reflect.Method;	$r0 = new java.lang.StringBuilder;	$r2 = virtualinvoke r1.<java.lang.reflect.Method: java.lang.String getName()>();	specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>($r2);	r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40);	r4 = virtualinvoke r1.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>();	i1 = 0;	$i0 = lengthof r4;	if i1 >= $i0 goto $r7 = virtualinvoke r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	$r7 = virtualinvoke r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	$r5 = virtualinvoke r1.<java.lang.reflect.Method: java.lang.Class getReturnType()>();	$r6 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getDesc(java.lang.Class)>($r5);	virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r8 = virtualinvoke r3.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 3