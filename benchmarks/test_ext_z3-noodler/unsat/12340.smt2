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

(declare-sort var2548 0)
(declare-sort var369 0)
(declare-sort var1408 0)
(declare-sort var2350 0)
(declare-sort var2288 0)
(declare-sort var2526 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1408_getParameter/-1739295734 (var2548 String String) String)
(declare-fun var2288_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var2350-init () var2350)
(declare-fun <init>/-1681595970 (var2350 String) void)
(declare-fun exists/1072868559 (var2350) Bool)
(declare-const null-var2548 var2548)
(declare-const null-String String)
(declare-const null-var2350 var2350)
(declare-const var2526-DEFAULT_CONFIG_CENTER_DIR_PATH String)
(declare-const var2667 var2548) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2667 null-var2548)))
 ; Statement: if r0 != null goto $r13 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(assert (not (not (= var2667 null-var2548)))) ; Negate: Cond: r0 != null  
(define-const var1056 String null-String) ; Statement: $r13 = null 
 ; Statement: goto [?= $r12 = staticinvoke <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.lang.String getParameter(org.apache.dubbo.common.URL,java.lang.String,java.lang.String)>(r0, "dubbo.config-center.dir", $r13)] 
(assert true) ; Non Conditional
(define-const var1890 String (var1408_getParameter/-1739295734 var2667 "dubbo.config-center.dir" var1056)) ; Statement: $r12 = staticinvoke <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.lang.String getParameter(org.apache.dubbo.common.URL,java.lang.String,java.lang.String)>(r0, "dubbo.config-center.dir", $r13) 
(define-const var1095 var2350 null-var2350) ; Statement: r14 = null 
(define-const var2271 Bool (var2288_isBlank/-523695098 (cast-from-String-to-String var1890))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r12) 
 ; Statement: if $z0 != 0 goto (branch) 
(assert (not (= (ite var2271 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: if $r12 == null goto $r1 = new java.io.File 
(assert (= var1890 null-String)) ; Cond: $r12 == null 
(define-const var2687 var2350 var2350-init) ; Statement: $r1 = new java.io.File 
(define-const var1975 String var2526-DEFAULT_CONFIG_CENTER_DIR_PATH) ; Statement: $r2 = <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.lang.String DEFAULT_CONFIG_CENTER_DIR_PATH> 
(assert true)
;(assert (<init>/-1681595970 var2687 var1975)) ; Statement: specialinvoke $r1.<java.io.File: void <init>(java.lang.String)>($r2) 

(declare-const var2687!1 var2350)
(declare-const var1975!1 String)
(define-const var1095!1 var2350 var2687!1) ; Statement: r14 = $r1 
(assert true) ; Non Conditional
(assert true)
(define-const var766 Bool (exists/1072868559 var1095!1)) ; Statement: $z3 = virtualinvoke r14.<java.io.File: boolean exists()>() 
 ; Statement: if $z3 != 0 goto return r14 
(assert (not (= (ite var766 1 0) 0))) ; Cond: $z3 != 0 
 ; Statement: return r14 
(check-sat)
; {var1408_getParameter/-1739295734=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var2288_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var2350-init=([], java.io.File), <init>/-1681595970=([java.io.File, java.lang.String], void), exists/1072868559=([java.io.File], boolean)}
; {var2548=org.apache.dubbo.common.URL, var2667=r0, var369=null_type, var1056=$r13, var1408=org.apache.dubbo.common.config.configcenter.AbstractDynamicConfiguration, var1890=$r12, var2350=java.io.File, var1095=r14, var2288=org.apache.dubbo.common.utils.StringUtils, var2271=$z0, var2687=$r1, var2526=org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration, var1975=$r2, var766=$z3}
; {org.apache.dubbo.common.URL=var2548, r0=var2667, null_type=var369, $r13=var1056, org.apache.dubbo.common.config.configcenter.AbstractDynamicConfiguration=var1408, $r12=var1890, java.io.File=var2350, r14=var1095, org.apache.dubbo.common.utils.StringUtils=var2288, $z0=var2271, $r1=var2687, org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration=var2526, $r2=var1975, $z3=var766}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.URL;	if r0 != null goto $r13 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	$r13 = null;	goto [?= $r12 = staticinvoke <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.lang.String getParameter(org.apache.dubbo.common.URL,java.lang.String,java.lang.String)>(r0, "dubbo.config-center.dir", $r13)];	$r12 = staticinvoke <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.lang.String getParameter(org.apache.dubbo.common.URL,java.lang.String,java.lang.String)>(r0, "dubbo.config-center.dir", $r13);	r14 = null;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r12);	if $z0 != 0 goto (branch);	if $r12 == null goto $r1 = new java.io.File;	$r1 = new java.io.File;	$r2 = <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.lang.String DEFAULT_CONFIG_CENTER_DIR_PATH>;	specialinvoke $r1.<java.io.File: void <init>(java.lang.String)>($r2);	r14 = $r1;	$z3 = virtualinvoke r14.<java.io.File: boolean exists()>();	if $z3 != 0 goto return r14;	return r14
;block_num 7