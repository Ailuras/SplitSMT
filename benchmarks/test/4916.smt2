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

(declare-sort var140 0)
(declare-sort var2924 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getReturnType/-1494237887 (var140) ClassObject)
(declare-fun var2924_getName/715767591 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(declare-fun getName/1227988463 (var140) String)
(declare-fun getParameterTypes/827748249 (var140) (Array Int ClassObject))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var140 var140)
(declare-const var3251 var140) ; Statement: r1 := @parameter0: java.lang.reflect.Method 
(assert (not (= var3251 null-var140)))
(define-const var296 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var296)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var296!1 String)
(assert (= var296!1 ""))
(assert true)
(define-const var2489 ClassObject (getReturnType/-1494237887 var3251)) ; Statement: $r2 = virtualinvoke r1.<java.lang.reflect.Method: java.lang.Class getReturnType()>() 
(define-const var643 String (var2924_getName/715767591 var2489)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getName(java.lang.Class)>($r2) 
(assert true)
(define-const var1249 String (append/672562846 var296!1 var643)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var296!2 String)
(assert (= var296!2 (str.++ var296!1 var643)))
(assert true)
;(assert (append/-1166366385 var1249 32)) ; Statement: virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(declare-const var1249!1 String)
(assert (str.prefixof var1249 var1249!1))
(assert true)
(define-const var1296 String (getName/1227988463 var3251)) ; Statement: $r5 = virtualinvoke r1.<java.lang.reflect.Method: java.lang.String getName()>() 
(assert true)
(define-const var428 String (append/672562846 var296!2 var1296)) ; Statement: $r6 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var296!3 String)
(assert (= var296!3 (str.++ var296!2 var1296)))
(assert true)
;(assert (append/-1166366385 var428 40)) ; Statement: virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40) 
(declare-const var428!1 String)
(assert (str.prefixof var428 var428!1))
(assert true)
(define-const var410 (Array Int ClassObject) (getParameterTypes/827748249 var3251)) ; Statement: r7 = virtualinvoke r1.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>() 
(define-const var2401 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
(define-const var2380 Int (getLength-Arr-ClassObject-1 var410)) ; Statement: $i0 = lengthof r7 
 ; Statement: if i1 >= $i0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(assert (>= var2401 var2380)) ; Cond: i1 >= $i0 
(assert true)
;(assert (append/-1166366385 var296!3 41)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(declare-const var296!4 String)
(assert (str.prefixof var296!3 var296!4))
(assert true)
(define-const var876 String (toString/-2075883882 var296!4)) ; Statement: $r8 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getReturnType/-1494237887=([java.lang.reflect.Method], java.lang.Class), var2924_getName/715767591=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), getName/1227988463=([java.lang.reflect.Method], java.lang.String), getParameterTypes/827748249=([java.lang.reflect.Method], java.lang.Class[]), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var140=java.lang.reflect.Method, var3251=r1, var296=$r0, var2489=$r2, var2924=org.apache.dubbo.common.utils.ReflectUtils, var643=$r3, var1249=$r4, var1296=$r5, var428=$r6, var410=r7, var2401=i1, var2380=$i0, var876=$r8}
; {java.lang.reflect.Method=var140, r1=var3251, $r0=var296, $r2=var2489, org.apache.dubbo.common.utils.ReflectUtils=var2924, $r3=var643, $r4=var1249, $r5=var1296, $r6=var428, r7=var410, i1=var2401, $i0=var2380, $r8=var876}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: java.lang.reflect.Method;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<java.lang.reflect.Method: java.lang.Class getReturnType()>();	$r3 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getName(java.lang.Class)>($r2);	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	$r5 = virtualinvoke r1.<java.lang.reflect.Method: java.lang.String getName()>();	$r6 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40);	r7 = virtualinvoke r1.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>();	i1 = 0;	$i0 = lengthof r7;	if i1 >= $i0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	$r8 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 3