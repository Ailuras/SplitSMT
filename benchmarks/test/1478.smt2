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

(declare-sort var2219 0)
(declare-sort var2943 0)
(declare-sort var588 0)
(declare-sort var3757 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun endsWith/985337093 ((s String) (suffix String)) Bool (str.suffixof suffix s))
(declare-fun getResourceAsStream/269938975 (var3757 String) var588)
(declare-fun cast-from-var2219-to-var3757 (var2219) var3757)
(declare-const null-var2219 var2219)
(declare-const null-String String)
(declare-const var25 var2219) ; Statement: r1 := @this: org.apache.dubbo.common.compiler.support.JdkCompiler$ClassLoaderImpl 
(assert (not (= var25 null-var2219)))
(declare-const var1537 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1537 null-String)))
(assert true)
(define-const var3938 Bool (endsWith/985337093 var1537 ".class")) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean endsWith(java.lang.String)>(".class") 
 ; Statement: if $z0 == 0 goto $r2 = specialinvoke r1.<java.lang.ClassLoader: java.io.InputStream getResourceAsStream(java.lang.String)>(r0) 
(assert (= (ite var3938 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var2596 var588 (getResourceAsStream/269938975 (cast-from-var2219-to-var3757 var25) var1537)) ; Statement: $r2 = specialinvoke r1.<java.lang.ClassLoader: java.io.InputStream getResourceAsStream(java.lang.String)>(r0) 
 ; Statement: return $r2 
(check-sat)
; {endsWith/985337093=([java.lang.String, java.lang.String], boolean), getResourceAsStream/269938975=([java.lang.ClassLoader, java.lang.String], java.io.InputStream), cast-from-var2219-to-var3757=([org.apache.dubbo.common.compiler.support.JdkCompiler$ClassLoaderImpl], java.lang.ClassLoader)}
; {var2219=org.apache.dubbo.common.compiler.support.JdkCompiler$ClassLoaderImpl, var25=r1, var1537=r0, var2943=null_type, var3938=$z0, var588=java.io.InputStream, var3757=java.lang.ClassLoader, var2596=$r2}
; {org.apache.dubbo.common.compiler.support.JdkCompiler$ClassLoaderImpl=var2219, r1=var25, r0=var1537, null_type=var2943, $z0=var3938, java.io.InputStream=var588, java.lang.ClassLoader=var3757, $r2=var2596}
;seq <java.lang.String: boolean endsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean endsWith(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.compiler.support.JdkCompiler$ClassLoaderImpl;	r0 := @parameter0: java.lang.String;	$z0 = virtualinvoke r0.<java.lang.String: boolean endsWith(java.lang.String)>(".class");	if $z0 == 0 goto $r2 = specialinvoke r1.<java.lang.ClassLoader: java.io.InputStream getResourceAsStream(java.lang.String)>(r0);	$r2 = specialinvoke r1.<java.lang.ClassLoader: java.io.InputStream getResourceAsStream(java.lang.String)>(r0);	return $r2
;block_num 2