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

(declare-sort var3398 0)
(declare-sort var1284 0)
(declare-sort var2779 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getAddress/-799241167 (var3398) String)
(declare-fun var1284_isEmpty/-813097145 (String) Bool)
(declare-fun var2779-init () var2779)
(declare-fun <init>/875830710 (var2779 String) void)
(declare-const null-var3398 var3398)
(declare-const var2721 var3398) ; Statement: r0 := @this: org.apache.dubbo.config.MetadataReportConfig 
(assert (not (= var2721 null-var3398)))
(assert true)
(define-const var1869 String (getAddress/-799241167 var2721)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.config.MetadataReportConfig: java.lang.String getAddress()>() 
(define-const var17 Bool (var1284_isEmpty/-813097145 var1869)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r2 = new java.util.HashMap 
(assert (not (= (ite var17 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1729 var2779 var2779-init) ; Statement: $r11 = new java.lang.IllegalArgumentException 
(assert true)
;(assert (<init>/875830710 var1729 "The address of metadata report is invalid.")) ; Statement: specialinvoke $r11.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>("The address of metadata report is invalid.") 

(declare-const var1729!1 var2779)
(declare-const var3779 String)
 ; Statement: throw $r11 
(check-sat)
; {getAddress/-799241167=([org.apache.dubbo.config.MetadataReportConfig], java.lang.String), var1284_isEmpty/-813097145=([java.lang.String], boolean), var2779-init=([], java.lang.IllegalArgumentException), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var3398=org.apache.dubbo.config.MetadataReportConfig, var2721=r0, var1869=r1, var1284=org.apache.dubbo.common.utils.StringUtils, var17=$z0, var2779=java.lang.IllegalArgumentException, var1729=$r11, var3779="The address of metadata report is invalid."}
; {org.apache.dubbo.config.MetadataReportConfig=var3398, r0=var2721, r1=var1869, org.apache.dubbo.common.utils.StringUtils=var1284, $z0=var17, java.lang.IllegalArgumentException=var2779, $r11=var1729, "The address of metadata report is invalid."=var3779}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.MetadataReportConfig;	r1 = virtualinvoke r0.<org.apache.dubbo.config.MetadataReportConfig: java.lang.String getAddress()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r2 = new java.util.HashMap;	$r11 = new java.lang.IllegalArgumentException;	specialinvoke $r11.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>("The address of metadata report is invalid.");	throw $r11
;block_num 2