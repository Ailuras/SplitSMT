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

(declare-sort var976 0)
(declare-sort var3237 0)
(declare-sort var131 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var976_get/-1216255739 (var976 Int) var3237)
(declare-fun cast-from-var3237-to-var131 (var3237) var131)
(declare-fun getField/-1781158780 (var131) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-String String)
(declare-const null-var976 var976)
(declare-const null-Int Int)
(declare-const var596 String) ; Statement: r0 := @parameter0: java.lang.StringBuilder 
(assert (not (= var596 null-String)))
(declare-const var3182 var976) ; Statement: r2 := @parameter1: java.util.List 
(assert (not (= var3182 null-var976)))
(declare-const var3477 Int) ; Statement: i0 := @parameter2: int 
(assert (not (= var3477 null-Int)))
(define-const var1376 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1376)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1376!1 String)
(assert (= var1376!1 ""))
(assert true)
(define-const var954 String (append/672562846 var1376!1 ", ")) ; Statement: $r6 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", ") 
(declare-const var1376!2 String)
(assert (= var1376!2 (str.++ var1376!1 ", ")))
(define-const var1588 var3237 (var976_get/-1216255739 var3182 var3477)) ; Statement: $r3 = interfaceinvoke r2.<java.util.List: java.lang.Object get(int)>(i0) 
(define-const var2663 var131 (cast-from-var3237-to-var131 var1588)) ; Statement: $r4 = (org.springframework.validation.FieldError) $r3 
(assert true)
(define-const var1488 String (getField/-1781158780 var2663)) ; Statement: $r5 = virtualinvoke $r4.<org.springframework.validation.FieldError: java.lang.String getField()>() 
(assert true)
(define-const var949 String (append/672562846 var954 var1488)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var954!1 String)
(assert (= var954!1 (str.++ var954 var1488)))
(assert true)
(define-const var942 String (toString/-2075883882 var949)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (append/672562846 var596 var942)) ; Statement: virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8) 
(declare-const var596!1 String)
(assert (= var596!1 (str.++ var596 var942)))
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var976_get/-1216255739=([java.util.List, int], java.lang.Object), cast-from-var3237-to-var131=([java.lang.Object], org.springframework.validation.FieldError), getField/-1781158780=([org.springframework.validation.FieldError], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var596=r0, var976=java.util.List, var3182=r2, var3477=i0, var1376=$r1, var954=$r6, var3237=java.lang.Object, var1588=$r3, var131=org.springframework.validation.FieldError, var2663=$r4, var1488=$r5, var949=$r7, var942=$r8}
; {r0=var596, java.util.List=var976, r2=var3182, i0=var3477, $r1=var1376, $r6=var954, java.lang.Object=var3237, $r3=var1588, org.springframework.validation.FieldError=var131, $r4=var2663, $r5=var1488, $r7=var949, $r8=var942}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.StringBuilder;	r2 := @parameter1: java.util.List;	i0 := @parameter2: int;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", ");	$r3 = interfaceinvoke r2.<java.util.List: java.lang.Object get(int)>(i0);	$r4 = (org.springframework.validation.FieldError) $r3;	$r5 = virtualinvoke $r4.<org.springframework.validation.FieldError: java.lang.String getField()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8);	return
;block_num 1