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

(declare-sort var3083 0)
(declare-sort var1733 0)
(declare-sort var1617 0)
(declare-sort var3328 0)
(declare-sort var3394 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var1617) void)
(declare-fun cast-from-var3083-to-var1617 (var3083) var1617)
(declare-fun maxAge/1248552812 (var3083) Int)
(declare-fun var3328_trim/1012475733 (String) String)
(declare-fun var3394_notEmptyString/1687515918 (String String) void)
(declare-fun name/1248552812 (var3083) String)
(declare-fun setValue/-238896579 (var3083 String) void)
(declare-const null-var3083 var3083)
(declare-const null-String String)
(declare-const var1208 var3083) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.HttpCookie 
(assert (not (= var1208 null-var3083)))
(declare-const var547 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var547 null-String)))
(declare-const var1977 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var1977 null-String)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var3083-to-var1617 var1208))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var1208!1 var3083)
(declare-const var1208!2 var3083)
(assert (not (= var1208!2 null-var3083)))
(assert (= (maxAge/1248552812 var1208!2) -9223372036854775808)) ; Statement: r0.<org.apache.dubbo.remoting.http12.HttpCookie: long maxAge> = -9223372036854775808L 
(define-const var2576 String (var3328_trim/1012475733 var547)) ; Statement: r3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String trim(java.lang.String)>(r2) 
;(assert (var3394_notEmptyString/1687515918 var2576 "name is required")) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void notEmptyString(java.lang.String,java.lang.String)>(r3, "name is required") 

(declare-const var2576!1 String)
(declare-const var3069 String)
(declare-const var1208!3 var3083)
(assert (not (= var1208!3 null-var3083)))
(assert (= (name/1248552812 var1208!3) var2576!1)) ; Statement: r0.<org.apache.dubbo.remoting.http12.HttpCookie: java.lang.String name> = r3 
(assert true)
;(assert (setValue/-238896579 var1208!3 var1977)) ; Statement: virtualinvoke r0.<org.apache.dubbo.remoting.http12.HttpCookie: void setValue(java.lang.String)>(r1) 

(declare-const var1208!4 var3083)
(declare-const var1977!1 String)
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var3083-to-var1617=([org.apache.dubbo.remoting.http12.HttpCookie], java.lang.Object), maxAge/1248552812=([org.apache.dubbo.remoting.http12.HttpCookie], long), var3328_trim/1012475733=([java.lang.String], java.lang.String), var3394_notEmptyString/1687515918=([java.lang.String, java.lang.String], void), name/1248552812=([org.apache.dubbo.remoting.http12.HttpCookie], java.lang.String), setValue/-238896579=([org.apache.dubbo.remoting.http12.HttpCookie, java.lang.String], void)}
; {var3083=org.apache.dubbo.remoting.http12.HttpCookie, var1208=r0, var547=r2, var1733=null_type, var1977=r1, var1617=java.lang.Object, var3328=org.apache.dubbo.common.utils.StringUtils, var2576=r3, var3394=org.apache.dubbo.common.utils.Assert, var3069="name is required"}
; {org.apache.dubbo.remoting.http12.HttpCookie=var3083, r0=var1208, r2=var547, null_type=var1733, r1=var1977, java.lang.Object=var1617, org.apache.dubbo.common.utils.StringUtils=var3328, r3=var2576, org.apache.dubbo.common.utils.Assert=var3394, "name is required"=var3069}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String trim(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String trim(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.HttpCookie;	r2 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	specialinvoke r0.<java.lang.Object: void <init>()>();	r0.<org.apache.dubbo.remoting.http12.HttpCookie: long maxAge> = -9223372036854775808L;	r3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String trim(java.lang.String)>(r2);	staticinvoke <org.apache.dubbo.common.utils.Assert: void notEmptyString(java.lang.String,java.lang.String)>(r3, "name is required");	r0.<org.apache.dubbo.remoting.http12.HttpCookie: java.lang.String name> = r3;	virtualinvoke r0.<org.apache.dubbo.remoting.http12.HttpCookie: void setValue(java.lang.String)>(r1);	return
;block_num 1