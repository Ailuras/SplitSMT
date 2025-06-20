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

(declare-sort var644 0)
(declare-sort var1330 0)
(declare-sort var3363 0)
(declare-sort var3652 0)
(declare-sort var158 0)
(declare-sort var1934 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getPath/898047937 (var644) String)
(declare-fun var1330_getParameter/-1739295734 (var644 String String) String)
(declare-fun var3652_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var3363-init () var3363)
(declare-fun <init>/-1681595970 (var3363 String) void)
(declare-fun exists/1072868559 (var3363) Bool)
(declare-const null-var644 var644)
(declare-const null-var3363 var3363)
(declare-const null-String String)
(declare-const var1934-DEFAULT_CONFIG_CENTER_DIR_PATH String)
(declare-const var2012 var644) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2012 null-var644)))
 ; Statement: if r0 != null goto $r13 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(assert (not (= var2012 null-var644))) ; Cond: r0 != null 
(assert true)
(define-const var3080 String (getPath/898047937 var2012)) ; Statement: $r13 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(assert true) ; Non Conditional
(define-const var937 String (var1330_getParameter/-1739295734 var2012 "dubbo.config-center.dir" var3080)) ; Statement: $r12 = staticinvoke <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.lang.String getParameter(org.apache.dubbo.common.URL,java.lang.String,java.lang.String)>(r0, "dubbo.config-center.dir", $r13) 
(define-const var2460 var3363 null-var3363) ; Statement: r14 = null 
(define-const var3435 Bool (var3652_isBlank/-523695098 (cast-from-String-to-String var937))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r12) 
 ; Statement: if $z0 != 0 goto (branch) 
(assert (not (= (ite var3435 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: if $r12 == null goto $r1 = new java.io.File 
(assert (= var937 null-String)) ; Cond: $r12 == null 
(define-const var2655 var3363 var3363-init) ; Statement: $r1 = new java.io.File 
(define-const var1717 String var1934-DEFAULT_CONFIG_CENTER_DIR_PATH) ; Statement: $r2 = <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.lang.String DEFAULT_CONFIG_CENTER_DIR_PATH> 
(assert true)
;(assert (<init>/-1681595970 var2655 var1717)) ; Statement: specialinvoke $r1.<java.io.File: void <init>(java.lang.String)>($r2) 

(declare-const var2655!1 var3363)
(declare-const var1717!1 String)
(define-const var2460!1 var3363 var2655!1) ; Statement: r14 = $r1 
(assert true) ; Non Conditional
(assert true)
(define-const var3400 Bool (exists/1072868559 var2460!1)) ; Statement: $z3 = virtualinvoke r14.<java.io.File: boolean exists()>() 
 ; Statement: if $z3 != 0 goto return r14 
(assert (not (= (ite var3400 1 0) 0))) ; Cond: $z3 != 0 
 ; Statement: return r14 
(check-sat)
; {getPath/898047937=([org.apache.dubbo.common.URL], java.lang.String), var1330_getParameter/-1739295734=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var3652_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var3363-init=([], java.io.File), <init>/-1681595970=([java.io.File, java.lang.String], void), exists/1072868559=([java.io.File], boolean)}
; {var644=org.apache.dubbo.common.URL, var2012=r0, var3080=$r13, var1330=org.apache.dubbo.common.config.configcenter.AbstractDynamicConfiguration, var937=$r12, var3363=java.io.File, var2460=r14, var3652=org.apache.dubbo.common.utils.StringUtils, var3435=$z0, var158=null_type, var2655=$r1, var1934=org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration, var1717=$r2, var3400=$z3}
; {org.apache.dubbo.common.URL=var644, r0=var2012, $r13=var3080, org.apache.dubbo.common.config.configcenter.AbstractDynamicConfiguration=var1330, $r12=var937, java.io.File=var3363, r14=var2460, org.apache.dubbo.common.utils.StringUtils=var3652, $z0=var3435, null_type=var158, $r1=var2655, org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration=var1934, $r2=var1717, $z3=var3400}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.URL;	if r0 != null goto $r13 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	$r13 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	$r12 = staticinvoke <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.lang.String getParameter(org.apache.dubbo.common.URL,java.lang.String,java.lang.String)>(r0, "dubbo.config-center.dir", $r13);	r14 = null;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r12);	if $z0 != 0 goto (branch);	if $r12 == null goto $r1 = new java.io.File;	$r1 = new java.io.File;	$r2 = <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.lang.String DEFAULT_CONFIG_CENTER_DIR_PATH>;	specialinvoke $r1.<java.io.File: void <init>(java.lang.String)>($r2);	r14 = $r1;	$z3 = virtualinvoke r14.<java.io.File: boolean exists()>();	if $z3 != 0 goto return r14;	return r14
;block_num 7