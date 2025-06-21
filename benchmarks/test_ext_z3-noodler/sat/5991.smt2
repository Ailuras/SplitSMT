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

(declare-sort var964 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var964_getOwnerType/-523154979 (var964) ClassObject)
(declare-fun var964_getRawType/305663496 (var964) ClassObject)
(define-fun cast-from-ClassObject-to-ClassObject ((arg ClassObject)) ClassObject arg)
(declare-fun var964_getActualTypeArguments/-973063842 (var964) (Array Int ClassObject))
(declare-fun getCanonicalName/935544231 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var964 var964)
(declare-const null-ClassObject ClassObject)
(declare-const null-__Array__Int__ClassObject__ (Array Int ClassObject))
(declare-const var3607 var964) ; Statement: r1 := @parameter0: java.lang.reflect.ParameterizedType 
(assert (not (= var3607 null-var964)))
(define-const var2106 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2106)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2106!1 String)
(assert (= var2106!1 ""))
(define-const var2684 ClassObject (var964_getOwnerType/-523154979 var3607)) ; Statement: r2 = interfaceinvoke r1.<java.lang.reflect.ParameterizedType: java.lang.reflect.Type getOwnerType()>() 
(define-const var976 ClassObject (var964_getRawType/305663496 var3607)) ; Statement: $r3 = interfaceinvoke r1.<java.lang.reflect.ParameterizedType: java.lang.reflect.Type getRawType()>() 
(define-const var1886 ClassObject (cast-from-ClassObject-to-ClassObject var976)) ; Statement: r4 = (java.lang.Class) $r3 
(define-const var2389 (Array Int ClassObject) (var964_getActualTypeArguments/-973063842 var3607)) ; Statement: r5 = interfaceinvoke r1.<java.lang.reflect.ParameterizedType: java.lang.reflect.Type[] getActualTypeArguments()>() 
 ; Statement: if r2 == null goto $r6 = virtualinvoke r4.<java.lang.Class: java.lang.String getCanonicalName()>() 
(assert (= var2684 null-ClassObject)) ; Cond: r2 == null 
(assert true)
(define-const var3445 String (getCanonicalName/935544231 var1886)) ; Statement: $r6 = virtualinvoke r4.<java.lang.Class: java.lang.String getCanonicalName()>() 
(assert true)
;(assert (append/672562846 var2106!1 var3445)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var2106!2 String)
(assert (= var2106!2 (str.++ var2106!1 var3445)))
(assert true) ; Non Conditional
 ; Statement: if r5 == null goto $r26 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= var2389 null-__Array__Int__ClassObject__)) ; Cond: r5 == null 
(assert true)
(define-const var3419 String (toString/-2075883882 var2106!2)) ; Statement: $r26 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r26 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var964_getOwnerType/-523154979=([java.lang.reflect.ParameterizedType], java.lang.reflect.Type), var964_getRawType/305663496=([java.lang.reflect.ParameterizedType], java.lang.reflect.Type), cast-from-ClassObject-to-ClassObject=([java.lang.reflect.Type], java.lang.Class), var964_getActualTypeArguments/-973063842=([java.lang.reflect.ParameterizedType], java.lang.reflect.Type[]), getCanonicalName/935544231=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var964=java.lang.reflect.ParameterizedType, var3607=r1, var2106=$r0, var2684=r2, var976=$r3, var1886=r4, var2389=r5, var3445=$r6, var3419=$r26}
; {java.lang.reflect.ParameterizedType=var964, r1=var3607, $r0=var2106, r2=var2684, $r3=var976, r4=var1886, r5=var2389, $r6=var3445, $r26=var3419}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: java.lang.reflect.ParameterizedType;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	r2 = interfaceinvoke r1.<java.lang.reflect.ParameterizedType: java.lang.reflect.Type getOwnerType()>();	$r3 = interfaceinvoke r1.<java.lang.reflect.ParameterizedType: java.lang.reflect.Type getRawType()>();	r4 = (java.lang.Class) $r3;	r5 = interfaceinvoke r1.<java.lang.reflect.ParameterizedType: java.lang.reflect.Type[] getActualTypeArguments()>();	if r2 == null goto $r6 = virtualinvoke r4.<java.lang.Class: java.lang.String getCanonicalName()>();	$r6 = virtualinvoke r4.<java.lang.Class: java.lang.String getCanonicalName()>();	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	if r5 == null goto $r26 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r26 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r26
;block_num 4