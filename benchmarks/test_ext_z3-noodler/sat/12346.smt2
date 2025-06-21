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

(declare-sort var1456 0)
(declare-sort var873 0)
(declare-sort var297 0)
(declare-sort var2753 0)
(declare-sort var3186 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getPath/898047937 (var1456) String)
(declare-fun var873_getParameter/-1739295734 (var1456 String String) String)
(declare-fun var2753_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun exists/1072868559 (var297) Bool)
(declare-const null-var1456 var1456)
(declare-const null-var297 var297)
(declare-const null-String String)
(declare-const var979 var1456) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var979 null-var1456)))
 ; Statement: if r0 != null goto $r13 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(assert (not (= var979 null-var1456))) ; Cond: r0 != null 
(assert true)
(define-const var2125 String (getPath/898047937 var979)) ; Statement: $r13 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(assert true) ; Non Conditional
(define-const var1414 String (var873_getParameter/-1739295734 var979 "dubbo.config-center.dir" var2125)) ; Statement: $r12 = staticinvoke <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.lang.String getParameter(org.apache.dubbo.common.URL,java.lang.String,java.lang.String)>(r0, "dubbo.config-center.dir", $r13) 
(define-const var184 var297 null-var297) ; Statement: r14 = null 
(define-const var1951 Bool (var2753_isBlank/-523695098 (cast-from-String-to-String var1414))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r12) 
 ; Statement: if $z0 != 0 goto (branch) 
(assert (not (= (ite var1951 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: if $r12 == null goto $r1 = new java.io.File 
(assert (not (= var1414 null-String))) ; Negate: Cond: $r12 == null  
(assert true)
(define-const var1719 Bool (exists/1072868559 var184)) ; Statement: $z2 = virtualinvoke r14.<java.io.File: boolean exists()>() 
 ; Statement: if $z2 != 0 goto $z3 = virtualinvoke r14.<java.io.File: boolean exists()>() 
(assert (not (= (ite var1719 1 0) 0))) ; Cond: $z2 != 0 
(assert true)
(define-const var2180 Bool (exists/1072868559 var184)) ; Statement: $z3 = virtualinvoke r14.<java.io.File: boolean exists()>() 
 ; Statement: if $z3 != 0 goto return r14 
(assert (not (= (ite var2180 1 0) 0))) ; Cond: $z3 != 0 
 ; Statement: return r14 
(check-sat)
; {getPath/898047937=([org.apache.dubbo.common.URL], java.lang.String), var873_getParameter/-1739295734=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var2753_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), exists/1072868559=([java.io.File], boolean)}
; {var1456=org.apache.dubbo.common.URL, var979=r0, var2125=$r13, var873=org.apache.dubbo.common.config.configcenter.AbstractDynamicConfiguration, var1414=$r12, var297=java.io.File, var184=r14, var2753=org.apache.dubbo.common.utils.StringUtils, var1951=$z0, var3186=null_type, var1719=$z2, var2180=$z3}
; {org.apache.dubbo.common.URL=var1456, r0=var979, $r13=var2125, org.apache.dubbo.common.config.configcenter.AbstractDynamicConfiguration=var873, $r12=var1414, java.io.File=var297, r14=var184, org.apache.dubbo.common.utils.StringUtils=var2753, $z0=var1951, null_type=var3186, $z2=var1719, $z3=var2180}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.URL;	if r0 != null goto $r13 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	$r13 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	$r12 = staticinvoke <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.lang.String getParameter(org.apache.dubbo.common.URL,java.lang.String,java.lang.String)>(r0, "dubbo.config-center.dir", $r13);	r14 = null;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r12);	if $z0 != 0 goto (branch);	if $r12 == null goto $r1 = new java.io.File;	$z2 = virtualinvoke r14.<java.io.File: boolean exists()>();	if $z2 != 0 goto $z3 = virtualinvoke r14.<java.io.File: boolean exists()>();	$z3 = virtualinvoke r14.<java.io.File: boolean exists()>();	if $z3 != 0 goto return r14;	return r14
;block_num 7