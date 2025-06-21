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

(declare-sort var3094 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun name/-1324330900 (var3094) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3094 var3094)
(declare-const var1588 var3094) ; Statement: r1 := @this: org.apache.dubbo.config.utils.SimpleReferenceCache 
(assert (not (= var1588 null-var3094)))
(define-const var2933 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2933)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2933!1 String)
(assert (= var2933!1 ""))
(assert true)
(define-const var1737 String (append/672562846 var2933!1 "ReferenceCache(name: ")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ReferenceCache(name: ") 
(declare-const var2933!2 String)
(assert (= var2933!2 (str.++ var2933!1 "ReferenceCache(name: ")))
(define-const var3521 String (name/-1324330900 var1588)) ; Statement: $r2 = r1.<org.apache.dubbo.config.utils.SimpleReferenceCache: java.lang.String name> 
(assert true)
(define-const var1773 String (append/672562846 var1737 var3521)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1737!1 String)
(assert (= var1737!1 (str.++ var1737 var3521)))
(assert true)
(define-const var2425 String (append/672562846 var1773 ")")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(")") 
(declare-const var1773!1 String)
(assert (= var1773!1 (str.++ var1773 ")")))
(assert true)
(define-const var2957 String (toString/-2075883882 var2425)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), name/-1324330900=([org.apache.dubbo.config.utils.SimpleReferenceCache], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3094=org.apache.dubbo.config.utils.SimpleReferenceCache, var1588=r1, var2933=$r0, var1737=$r3, var3521=$r2, var1773=$r4, var2425=$r5, var2957=$r6}
; {org.apache.dubbo.config.utils.SimpleReferenceCache=var3094, r1=var1588, $r0=var2933, $r3=var1737, $r2=var3521, $r4=var1773, $r5=var2425, $r6=var2957}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.config.utils.SimpleReferenceCache;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ReferenceCache(name: ");	$r2 = r1.<org.apache.dubbo.config.utils.SimpleReferenceCache: java.lang.String name>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(")");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1