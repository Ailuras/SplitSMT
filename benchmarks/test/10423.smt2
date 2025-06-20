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

(declare-sort var1442 0)
(declare-sort var1573 0)
(declare-sort var762 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun path/2052580610 (var762) String)
(declare-fun cast-from-var1442-to-var762 (var1442) var762)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1442 var1442)
(declare-const null-String String)
(declare-const var2981 var1442) ; Statement: r3 := @this: org.apache.dubbo.config.ServiceConfig 
(assert (not (= var2981 null-var1442)))
(declare-const var3244 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3244 null-String)))
(define-const var47 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var47)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var47!1 String)
(assert (= var47!1 ""))
(assert true)
(define-const var938 String (append/672562846 var47!1 var3244)) ; Statement: $r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var47!2 String)
(assert (= var47!2 (str.++ var47!1 var3244)))
(assert true)
(define-const var1672 String (append/672562846 var938 "/")) ; Statement: $r5 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/") 
(declare-const var938!1 String)
(assert (= var938!1 (str.++ var938 "/")))
(define-const var1269 String (path/2052580610 (cast-from-var1442-to-var762 var2981))) ; Statement: $r4 = r3.<org.apache.dubbo.config.ServiceConfig: java.lang.String path> 
(assert true)
(define-const var1829 String (append/672562846 var1672 var1269)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var1672!1 String)
(assert (= var1672!1 (str.++ var1672 var1269)))
(assert true)
(define-const var2526 String (toString/-2075883882 var1829)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r7 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), path/2052580610=([org.apache.dubbo.config.ServiceConfigBase], java.lang.String), cast-from-var1442-to-var762=([org.apache.dubbo.config.ServiceConfig], org.apache.dubbo.config.ServiceConfigBase), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1442=org.apache.dubbo.config.ServiceConfig, var2981=r3, var3244=r1, var1573=null_type, var47=$r0, var938=$r2, var1672=$r5, var762=org.apache.dubbo.config.ServiceConfigBase, var1269=$r4, var1829=$r6, var2526=$r7}
; {org.apache.dubbo.config.ServiceConfig=var1442, r3=var2981, r1=var3244, null_type=var1573, $r0=var47, $r2=var938, $r5=var1672, org.apache.dubbo.config.ServiceConfigBase=var762, $r4=var1269, $r6=var1829, $r7=var2526}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @this: org.apache.dubbo.config.ServiceConfig;	r1 := @parameter0: java.lang.String;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r5 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/");	$r4 = r3.<org.apache.dubbo.config.ServiceConfig: java.lang.String path>;	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	return $r7
;block_num 1