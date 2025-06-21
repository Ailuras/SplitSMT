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

(declare-sort var2619 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getType/-1589499836 (var2619) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(declare-fun getSubtype/-2049901150 (var2619) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2619 var2619)
(declare-const var777 var2619) ; Statement: r1 := @parameter0: javax.ws.rs.core.MediaType 
(assert (not (= var777 null-var2619)))
(define-const var2947 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2947)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2947!1 String)
(assert (= var2947!1 ""))
(assert true)
(define-const var588 String (getType/-1589499836 var777)) ; Statement: $r2 = virtualinvoke r1.<javax.ws.rs.core.MediaType: java.lang.String getType()>() 
(assert true)
(define-const var1855 String (append/672562846 var2947!1 var588)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var2947!2 String)
(assert (= var2947!2 (str.++ var2947!1 var588)))
(assert true)
(define-const var1670 String (append/-1166366385 var1855 47)) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(47) 
(declare-const var1855!1 String)
(assert (str.prefixof var1855 var1855!1))
(assert true)
(define-const var3044 String (getSubtype/-2049901150 var777)) ; Statement: $r4 = virtualinvoke r1.<javax.ws.rs.core.MediaType: java.lang.String getSubtype()>() 
(assert true)
(define-const var2810 String (append/672562846 var1670 var3044)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var1670!1 String)
(assert (= var1670!1 (str.++ var1670 var3044)))
(assert true)
(define-const var1966 String (toString/-2075883882 var2810)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r7 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getType/-1589499836=([javax.ws.rs.core.MediaType], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), getSubtype/-2049901150=([javax.ws.rs.core.MediaType], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2619=javax.ws.rs.core.MediaType, var777=r1, var2947=$r0, var588=$r2, var1855=$r3, var1670=$r5, var3044=$r4, var2810=$r6, var1966=$r7}
; {javax.ws.rs.core.MediaType=var2619, r1=var777, $r0=var2947, $r2=var588, $r3=var1855, $r5=var1670, $r4=var3044, $r6=var2810, $r7=var1966}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: javax.ws.rs.core.MediaType;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<javax.ws.rs.core.MediaType: java.lang.String getType()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(47);	$r4 = virtualinvoke r1.<javax.ws.rs.core.MediaType: java.lang.String getSubtype()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	return $r7
;block_num 1