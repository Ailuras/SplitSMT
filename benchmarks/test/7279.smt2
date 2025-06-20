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

(declare-sort var2213 0)
(declare-sort var2395 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2395-init () var2395)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun providerIds/2052580610 (var2213) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1092629202 (var2395 String) void)
(declare-const null-var2213 var2213)
(declare-const var1625 var2213) ; Statement: r2 := @this: org.apache.dubbo.config.ServiceConfigBase 
(assert (not (= var1625 null-var2213)))
(define-const var525 var2395 var2395-init) ; Statement: $r0 = new java.lang.IllegalStateException 
(define-const var55 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var55)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var55!1 String)
(assert (= var55!1 ""))
(assert true)
(define-const var1520 String (append/672562846 var55!1 "Provider config not found: ")) ; Statement: $r4 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Provider config not found: ") 
(declare-const var55!2 String)
(assert (= var55!2 (str.++ var55!1 "Provider config not found: ")))
(define-const var2508 String (providerIds/2052580610 var1625)) ; Statement: $r3 = r2.<org.apache.dubbo.config.ServiceConfigBase: java.lang.String providerIds> 
(assert true)
(define-const var815 String (append/672562846 var1520 var2508)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var1520!1 String)
(assert (= var1520!1 (str.++ var1520 var2508)))
(assert true)
(define-const var1795 String (toString/-2075883882 var815)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var525 var1795)) ; Statement: specialinvoke $r0.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r6) 

(declare-const var525!1 var2395)
(declare-const var1795!1 String)
 ; Statement: return $r0 
(check-sat)
; {var2395-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), providerIds/2052580610=([org.apache.dubbo.config.ServiceConfigBase], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var2213=org.apache.dubbo.config.ServiceConfigBase, var1625=r2, var2395=java.lang.IllegalStateException, var525=$r0, var55=$r1, var1520=$r4, var2508=$r3, var815=$r5, var1795=$r6}
; {org.apache.dubbo.config.ServiceConfigBase=var2213, r2=var1625, java.lang.IllegalStateException=var2395, $r0=var525, $r1=var55, $r4=var1520, $r3=var2508, $r5=var815, $r6=var1795}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.config.ServiceConfigBase;	$r0 = new java.lang.IllegalStateException;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Provider config not found: ");	$r3 = r2.<org.apache.dubbo.config.ServiceConfigBase: java.lang.String providerIds>;	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r0.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r6);	return $r0
;block_num 1