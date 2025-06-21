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

(declare-sort var1992 0)
(declare-sort var346 0)
(declare-sort var2020 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun path/2052580610 (var2020) String)
(declare-fun cast-from-var1992-to-var2020 (var1992) var2020)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1992 var1992)
(declare-const null-String String)
(declare-const var1741 var1992) ; Statement: r3 := @this: org.apache.dubbo.config.ServiceConfig 
(assert (not (= var1741 null-var1992)))
(declare-const var3666 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3666 null-String)))
(define-const var1319 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1319)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1319!1 String)
(assert (= var1319!1 ""))
(assert true)
(define-const var3057 String (append/672562846 var1319!1 var3666)) ; Statement: $r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var1319!2 String)
(assert (= var1319!2 (str.++ var1319!1 var3666)))
(assert true)
(define-const var2678 String (append/672562846 var3057 "/")) ; Statement: $r5 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/") 
(declare-const var3057!1 String)
(assert (= var3057!1 (str.++ var3057 "/")))
(define-const var3165 String (path/2052580610 (cast-from-var1992-to-var2020 var1741))) ; Statement: $r4 = r3.<org.apache.dubbo.config.ServiceConfig: java.lang.String path> 
(assert true)
(define-const var654 String (append/672562846 var2678 var3165)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var2678!1 String)
(assert (= var2678!1 (str.++ var2678 var3165)))
(assert true)
(define-const var1461 String (toString/-2075883882 var654)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r7 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), path/2052580610=([org.apache.dubbo.config.ServiceConfigBase], java.lang.String), cast-from-var1992-to-var2020=([org.apache.dubbo.config.ServiceConfig], org.apache.dubbo.config.ServiceConfigBase), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1992=org.apache.dubbo.config.ServiceConfig, var1741=r3, var3666=r1, var346=null_type, var1319=$r0, var3057=$r2, var2678=$r5, var2020=org.apache.dubbo.config.ServiceConfigBase, var3165=$r4, var654=$r6, var1461=$r7}
; {org.apache.dubbo.config.ServiceConfig=var1992, r3=var1741, r1=var3666, null_type=var346, $r0=var1319, $r2=var3057, $r5=var2678, org.apache.dubbo.config.ServiceConfigBase=var2020, $r4=var3165, $r6=var654, $r7=var1461}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @this: org.apache.dubbo.config.ServiceConfig;	r1 := @parameter0: java.lang.String;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r5 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/");	$r4 = r3.<org.apache.dubbo.config.ServiceConfig: java.lang.String path>;	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	return $r7
;block_num 1