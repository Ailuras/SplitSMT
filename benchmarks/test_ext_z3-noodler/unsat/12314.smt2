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

(declare-sort var2076 0)
(declare-sort var1106 0)
(declare-sort var2452 0)
(declare-sort var1784 0)
(declare-sort var3378 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2452_getParameter/-1739295734 (var2076 String String) String)
(declare-fun var3378_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun exists/1072868559 (var1784) Bool)
(declare-const null-var2076 var2076)
(declare-const null-String String)
(declare-const null-var1784 var1784)
(declare-const var1025 var2076) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1025 null-var2076)))
 ; Statement: if r0 != null goto $r13 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(assert (not (not (= var1025 null-var2076)))) ; Negate: Cond: r0 != null  
(define-const var504 String null-String) ; Statement: $r13 = null 
 ; Statement: goto [?= $r12 = staticinvoke <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.lang.String getParameter(org.apache.dubbo.common.URL,java.lang.String,java.lang.String)>(r0, "dubbo.config-center.dir", $r13)] 
(assert true) ; Non Conditional
(define-const var2999 String (var2452_getParameter/-1739295734 var1025 "dubbo.config-center.dir" var504)) ; Statement: $r12 = staticinvoke <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.lang.String getParameter(org.apache.dubbo.common.URL,java.lang.String,java.lang.String)>(r0, "dubbo.config-center.dir", $r13) 
(define-const var2333 var1784 null-var1784) ; Statement: r14 = null 
(define-const var2439 Bool (var3378_isBlank/-523695098 (cast-from-String-to-String var2999))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r12) 
 ; Statement: if $z0 != 0 goto (branch) 
(assert (not (= (ite var2439 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: if $r12 == null goto $r1 = new java.io.File 
(assert (not (= var2999 null-String))) ; Negate: Cond: $r12 == null  
(assert true)
(define-const var1601 Bool (exists/1072868559 var2333)) ; Statement: $z2 = virtualinvoke r14.<java.io.File: boolean exists()>() 
 ; Statement: if $z2 != 0 goto $z3 = virtualinvoke r14.<java.io.File: boolean exists()>() 
(assert (not (= (ite var1601 1 0) 0))) ; Cond: $z2 != 0 
(assert true)
(define-const var2905 Bool (exists/1072868559 var2333)) ; Statement: $z3 = virtualinvoke r14.<java.io.File: boolean exists()>() 
 ; Statement: if $z3 != 0 goto return r14 
(assert (not (= (ite var2905 1 0) 0))) ; Cond: $z3 != 0 
 ; Statement: return r14 
(check-sat)
; {var2452_getParameter/-1739295734=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var3378_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), exists/1072868559=([java.io.File], boolean)}
; {var2076=org.apache.dubbo.common.URL, var1025=r0, var1106=null_type, var504=$r13, var2452=org.apache.dubbo.common.config.configcenter.AbstractDynamicConfiguration, var2999=$r12, var1784=java.io.File, var2333=r14, var3378=org.apache.dubbo.common.utils.StringUtils, var2439=$z0, var1601=$z2, var2905=$z3}
; {org.apache.dubbo.common.URL=var2076, r0=var1025, null_type=var1106, $r13=var504, org.apache.dubbo.common.config.configcenter.AbstractDynamicConfiguration=var2452, $r12=var2999, java.io.File=var1784, r14=var2333, org.apache.dubbo.common.utils.StringUtils=var3378, $z0=var2439, $z2=var1601, $z3=var2905}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.URL;	if r0 != null goto $r13 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	$r13 = null;	goto [?= $r12 = staticinvoke <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.lang.String getParameter(org.apache.dubbo.common.URL,java.lang.String,java.lang.String)>(r0, "dubbo.config-center.dir", $r13)];	$r12 = staticinvoke <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.lang.String getParameter(org.apache.dubbo.common.URL,java.lang.String,java.lang.String)>(r0, "dubbo.config-center.dir", $r13);	r14 = null;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r12);	if $z0 != 0 goto (branch);	if $r12 == null goto $r1 = new java.io.File;	$z2 = virtualinvoke r14.<java.io.File: boolean exists()>();	if $z2 != 0 goto $z3 = virtualinvoke r14.<java.io.File: boolean exists()>();	$z3 = virtualinvoke r14.<java.io.File: boolean exists()>();	if $z3 != 0 goto return r14;	return r14
;block_num 7