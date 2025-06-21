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

(declare-sort var1839 0)
(declare-sort var1946 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun append/-1166366385 (String Int) String)
(declare-fun getParameterTypes/827748249 (var1839) (Array Int ClassObject))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(declare-fun getReturnType/-1494237887 (var1839) ClassObject)
(declare-fun var1946_getDesc/-297103955 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1839 var1839)
(declare-const var60 var1839) ; Statement: r1 := @parameter0: java.lang.reflect.Method 
(assert (not (= var60 null-var1839)))
(define-const var403 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var403)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var403!1 String)
(assert (= var403!1 ""))
(assert true)
;(assert (append/-1166366385 var403!1 40)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40) 
(declare-const var403!2 String)
(assert (str.prefixof var403!1 var403!2))
(assert true)
(define-const var3884 (Array Int ClassObject) (getParameterTypes/827748249 var60)) ; Statement: r2 = virtualinvoke r1.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>() 
(define-const var321 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
(define-const var642 Int (getLength-Arr-ClassObject-1 var3884)) ; Statement: $i0 = lengthof r2 
 ; Statement: if i1 >= $i0 goto $r5 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(assert (>= var321 var642)) ; Cond: i1 >= $i0 
(assert true)
(define-const var1223 String (append/-1166366385 var403!2 41)) ; Statement: $r5 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(declare-const var403!3 String)
(assert (str.prefixof var403!2 var403!3))
(assert true)
(define-const var773 ClassObject (getReturnType/-1494237887 var60)) ; Statement: $r3 = virtualinvoke r1.<java.lang.reflect.Method: java.lang.Class getReturnType()>() 
(define-const var3570 String (var1946_getDesc/-297103955 var773)) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getDesc(java.lang.Class)>($r3) 
(assert true)
;(assert (append/672562846 var1223 var3570)) ; Statement: virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var1223!1 String)
(assert (= var1223!1 (str.++ var1223 var3570)))
(assert true)
(define-const var3548 String (toString/-2075883882 var403!3)) ; Statement: $r6 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), getParameterTypes/827748249=([java.lang.reflect.Method], java.lang.Class[]), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), getReturnType/-1494237887=([java.lang.reflect.Method], java.lang.Class), var1946_getDesc/-297103955=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1839=java.lang.reflect.Method, var60=r1, var403=$r0, var3884=r2, var321=i1, var642=$i0, var1223=$r5, var773=$r3, var1946=org.apache.dubbo.common.utils.ReflectUtils, var3570=$r4, var3548=$r6}
; {java.lang.reflect.Method=var1839, r1=var60, $r0=var403, r2=var3884, i1=var321, $i0=var642, $r5=var1223, $r3=var773, org.apache.dubbo.common.utils.ReflectUtils=var1946, $r4=var3570, $r6=var3548}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: java.lang.reflect.Method;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40);	r2 = virtualinvoke r1.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>();	i1 = 0;	$i0 = lengthof r2;	if i1 >= $i0 goto $r5 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	$r5 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	$r3 = virtualinvoke r1.<java.lang.reflect.Method: java.lang.Class getReturnType()>();	$r4 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getDesc(java.lang.Class)>($r3);	virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r6 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 3