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

(declare-sort var2203 0)
(declare-sort var526 0)
(declare-sort var3799 0)
(declare-sort var1798 0)
(declare-sort var501 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameterTypes/827748249 (var3799) (Array Int ClassObject))
(declare-fun hasIndex/1865153751 (var2203 var526) Bool)
(declare-fun getIndex/1105932516 (var526) Int)
(declare-fun getType/-1080442783 (var526) String)
(declare-fun isTypeMatched/1638997197 (var2203 String Int (Array Int ClassObject)) Bool)
(declare-fun var1798-init () var1798)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var501) String)
(declare-fun cast-from-Int-to-var501 (Int) var501)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var1798 String) void)
(declare-const null-var2203 var2203)
(declare-const null-var526 var526)
(declare-const null-var3799 var3799)
(declare-const var899 var2203) ; Statement: r2 := @this: org.apache.dubbo.config.ServiceConfig 
(assert (not (= var899 null-var2203)))
(declare-const var1353 var526) ; Statement: r3 := @parameter0: org.apache.dubbo.config.ArgumentConfig 
(assert (not (= var1353 null-var526)))
(declare-const var2661 var3799) ; Statement: r0 := @parameter1: java.lang.reflect.Method 
(assert (not (= var2661 null-var3799)))
(assert true)
(define-const var2242 (Array Int ClassObject) (getParameterTypes/827748249 var2661)) ; Statement: r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>() 
(assert true)
(define-const var653 Bool (hasIndex/1865153751 var899 var1353)) ; Statement: $z0 = specialinvoke r2.<org.apache.dubbo.config.ServiceConfig: boolean hasIndex(org.apache.dubbo.config.ArgumentConfig)>(r3) 
 ; Statement: if $z0 == 0 goto i1 = 0 
(assert (not (= (ite var653 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var3869 Int (getIndex/1105932516 var1353)) ; Statement: r23 = virtualinvoke r3.<org.apache.dubbo.config.ArgumentConfig: java.lang.Integer getIndex()>() 
(assert true)
(define-const var3224 String (getType/-1080442783 var1353)) ; Statement: r13 = virtualinvoke r3.<org.apache.dubbo.config.ArgumentConfig: java.lang.String getType()>() 
(assert true)
(define-const var2746 Bool (isTypeMatched/1638997197 var899 var3224 var3869 var2242)) ; Statement: $z2 = specialinvoke r2.<org.apache.dubbo.config.ServiceConfig: boolean isTypeMatched(java.lang.String,java.lang.Integer,java.lang.Class[])>(r13, r23, r1) 
 ; Statement: if $z2 == 0 goto $r14 = new java.lang.IllegalArgumentException 
(assert (= (ite var2746 1 0) 0)) ; Cond: $z2 == 0 
(define-const var2161 var1798 var1798-init) ; Statement: $r14 = new java.lang.IllegalArgumentException 
(define-const var3027 String String-init) ; Statement: $r15 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3027)) ; Statement: specialinvoke $r15.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3027!1 String)
(assert (= var3027!1 ""))
(assert true)
(define-const var3049 String (append/672562846 var3027!1 "Argument config error : the index attribute and type attribute not match :index :")) ; Statement: $r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Argument config error : the index attribute and type attribute not match :index :") 
(declare-const var3027!2 String)
(assert (= var3027!2 (str.++ var3027!1 "Argument config error : the index attribute and type attribute not match :index :")))
(assert true)
(define-const var961 Int (getIndex/1105932516 var1353)) ; Statement: $r16 = virtualinvoke r3.<org.apache.dubbo.config.ArgumentConfig: java.lang.Integer getIndex()>() 
(assert true)
(define-const var3826 String (append/-1031950772 var3049 (cast-from-Int-to-var501 var961))) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r16) 
(declare-const var3049!1 String)
(assert (str.prefixof var3049 var3049!1))
(assert true)
(define-const var1639 String (append/672562846 var3826 ", type:")) ; Statement: $r20 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", type:") 
(declare-const var3826!1 String)
(assert (= var3826!1 (str.++ var3826 ", type:")))
(assert true)
(define-const var1459 String (getType/-1080442783 var1353)) ; Statement: $r19 = virtualinvoke r3.<org.apache.dubbo.config.ArgumentConfig: java.lang.String getType()>() 
(assert true)
(define-const var3346 String (append/672562846 var1639 var1459)) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r19) 
(declare-const var1639!1 String)
(assert (= var1639!1 (str.++ var1639 var1459)))
(assert true)
(define-const var2017 String (toString/-2075883882 var3346)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var2161 var2017)) ; Statement: specialinvoke $r14.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r22) 

(declare-const var2161!1 var1798)
(declare-const var2017!1 String)
 ; Statement: throw $r14 
(check-sat)
; {getParameterTypes/827748249=([java.lang.reflect.Method], java.lang.Class[]), hasIndex/1865153751=([org.apache.dubbo.config.ServiceConfig, org.apache.dubbo.config.ArgumentConfig], boolean), getIndex/1105932516=([org.apache.dubbo.config.ArgumentConfig], java.lang.Integer), getType/-1080442783=([org.apache.dubbo.config.ArgumentConfig], java.lang.String), isTypeMatched/1638997197=([org.apache.dubbo.config.ServiceConfig, java.lang.String, java.lang.Integer, java.lang.Class[]], boolean), var1798-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-Int-to-var501=([java.lang.Integer], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var2203=org.apache.dubbo.config.ServiceConfig, var899=r2, var526=org.apache.dubbo.config.ArgumentConfig, var1353=r3, var3799=java.lang.reflect.Method, var2661=r0, var2242=r1, var653=$z0, var3869=r23, var3224=r13, var2746=$z2, var1798=java.lang.IllegalArgumentException, var2161=$r14, var3027=$r15, var3049=$r17, var961=$r16, var501=java.lang.Object, var3826=$r18, var1639=$r20, var1459=$r19, var3346=$r21, var2017=$r22}
; {org.apache.dubbo.config.ServiceConfig=var2203, r2=var899, org.apache.dubbo.config.ArgumentConfig=var526, r3=var1353, java.lang.reflect.Method=var3799, r0=var2661, r1=var2242, $z0=var653, r23=var3869, r13=var3224, $z2=var2746, java.lang.IllegalArgumentException=var1798, $r14=var2161, $r15=var3027, $r17=var3049, $r16=var961, java.lang.Object=var501, $r18=var3826, $r20=var1639, $r19=var1459, $r21=var3346, $r22=var2017}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.config.ServiceConfig;	r3 := @parameter0: org.apache.dubbo.config.ArgumentConfig;	r0 := @parameter1: java.lang.reflect.Method;	r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class[] getParameterTypes()>();	$z0 = specialinvoke r2.<org.apache.dubbo.config.ServiceConfig: boolean hasIndex(org.apache.dubbo.config.ArgumentConfig)>(r3);	if $z0 == 0 goto i1 = 0;	r23 = virtualinvoke r3.<org.apache.dubbo.config.ArgumentConfig: java.lang.Integer getIndex()>();	r13 = virtualinvoke r3.<org.apache.dubbo.config.ArgumentConfig: java.lang.String getType()>();	$z2 = specialinvoke r2.<org.apache.dubbo.config.ServiceConfig: boolean isTypeMatched(java.lang.String,java.lang.Integer,java.lang.Class[])>(r13, r23, r1);	if $z2 == 0 goto $r14 = new java.lang.IllegalArgumentException;	$r14 = new java.lang.IllegalArgumentException;	$r15 = new java.lang.StringBuilder;	specialinvoke $r15.<java.lang.StringBuilder: void <init>()>();	$r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Argument config error : the index attribute and type attribute not match :index :");	$r16 = virtualinvoke r3.<org.apache.dubbo.config.ArgumentConfig: java.lang.Integer getIndex()>();	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r16);	$r20 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", type:");	$r19 = virtualinvoke r3.<org.apache.dubbo.config.ArgumentConfig: java.lang.String getType()>();	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r19);	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r14.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r22);	throw $r14
;block_num 3