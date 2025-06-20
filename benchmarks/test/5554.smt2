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

(declare-sort var3880 0)
(declare-sort var2517 0)
(declare-sort var3539 0)
(declare-sort var3535 0)
(declare-sort var1726 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getCachedNumber/854871038 (var3880 String String) var3539)
(declare-fun getMethodParameter/2015795402 (var3535 String String) String)
(declare-fun cast-from-var3880-to-var3535 (var3880) var3535)
(declare-fun var1726_isEmpty/-813097145 (String) Bool)
(declare-fun Int_parseByte/566405473 (String) Int)
(declare-fun Int_valueOf/-1256543613 (Int) Int)
(declare-fun updateCachedNumber/-1510822591 (var3880 String String var3539) void)
(declare-fun cast-from-Int-to-var3539 (Int) var3539)
(declare-const null-var3880 var3880)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const null-var3539 var3539)
(declare-const var3676 var3880) ; Statement: r0 := @this: org.apache.dubbo.common.url.component.ServiceConfigURL 
(assert (not (= var3676 null-var3880)))
(declare-const var2739 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2739 null-String)))
(declare-const var2907 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2907 null-String)))
(declare-const var3937 Int) ; Statement: b1 := @parameter2: byte 
(assert (not (= var3937 null-Int)))
(assert true)
(define-const var2231 var3539 (getCachedNumber/854871038 var3676 var2739 var2907)) ; Statement: r3 = specialinvoke r0.<org.apache.dubbo.common.url.component.ServiceConfigURL: java.lang.Number getCachedNumber(java.lang.String,java.lang.String)>(r1, r2) 
 ; Statement: if r3 == null goto r4 = virtualinvoke r0.<org.apache.dubbo.common.url.component.ServiceConfigURL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(assert (= var2231 null-var3539)) ; Cond: r3 == null 
(assert true)
(define-const var2319 String (getMethodParameter/2015795402 (cast-from-var3880-to-var3535 var3676) var2739 var2907)) ; Statement: r4 = virtualinvoke r0.<org.apache.dubbo.common.url.component.ServiceConfigURL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var2239 Bool (var1726_isEmpty/-813097145 var2319)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto b0 = staticinvoke <java.lang.Byte: byte parseByte(java.lang.String)>(r4) 
(assert (= (ite var2239 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2224 Int (Int_parseByte/566405473 var2319)) ; Statement: b0 = staticinvoke <java.lang.Byte: byte parseByte(java.lang.String)>(r4) 
(define-const var202 Int (Int_valueOf/-1256543613 var2224)) ; Statement: $r5 = staticinvoke <java.lang.Byte: java.lang.Byte valueOf(byte)>(b0) 
(assert true)
;(assert (updateCachedNumber/-1510822591 var3676 var2739 var2907 (cast-from-Int-to-var3539 var202))) ; Statement: specialinvoke r0.<org.apache.dubbo.common.url.component.ServiceConfigURL: void updateCachedNumber(java.lang.String,java.lang.String,java.lang.Number)>(r1, r2, $r5) 

(declare-const var3676!1 var3880)
(declare-const var2739!1 String)
(declare-const var2907!1 String)
(declare-const var202!1 Int)
 ; Statement: return b0 
(check-sat)
; {getCachedNumber/854871038=([org.apache.dubbo.common.url.component.ServiceConfigURL, java.lang.String, java.lang.String], java.lang.Number), getMethodParameter/2015795402=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), cast-from-var3880-to-var3535=([org.apache.dubbo.common.url.component.ServiceConfigURL], org.apache.dubbo.common.URL), var1726_isEmpty/-813097145=([java.lang.String], boolean), Int_parseByte/566405473=([java.lang.String], byte), Int_valueOf/-1256543613=([byte], java.lang.Byte), updateCachedNumber/-1510822591=([org.apache.dubbo.common.url.component.ServiceConfigURL, java.lang.String, java.lang.String, java.lang.Number], void), cast-from-Int-to-var3539=([java.lang.Byte], java.lang.Number)}
; {var3880=org.apache.dubbo.common.url.component.ServiceConfigURL, var3676=r0, var2739=r1, var2517=null_type, var2907=r2, var3937=b1, var3539=java.lang.Number, var2231=r3, var3535=org.apache.dubbo.common.URL, var2319=r4, var1726=org.apache.dubbo.common.utils.StringUtils, var2239=$z0, var2224=b0, var202=$r5}
; {org.apache.dubbo.common.url.component.ServiceConfigURL=var3880, r0=var3676, r1=var2739, null_type=var2517, r2=var2907, b1=var3937, java.lang.Number=var3539, r3=var2231, org.apache.dubbo.common.URL=var3535, r4=var2319, org.apache.dubbo.common.utils.StringUtils=var1726, $z0=var2239, b0=var2224, $r5=var202}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.url.component.ServiceConfigURL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	b1 := @parameter2: byte;	r3 = specialinvoke r0.<org.apache.dubbo.common.url.component.ServiceConfigURL: java.lang.Number getCachedNumber(java.lang.String,java.lang.String)>(r1, r2);	if r3 == null goto r4 = virtualinvoke r0.<org.apache.dubbo.common.url.component.ServiceConfigURL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	r4 = virtualinvoke r0.<org.apache.dubbo.common.url.component.ServiceConfigURL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4);	if $z0 == 0 goto b0 = staticinvoke <java.lang.Byte: byte parseByte(java.lang.String)>(r4);	b0 = staticinvoke <java.lang.Byte: byte parseByte(java.lang.String)>(r4);	$r5 = staticinvoke <java.lang.Byte: java.lang.Byte valueOf(byte)>(b0);	specialinvoke r0.<org.apache.dubbo.common.url.component.ServiceConfigURL: void updateCachedNumber(java.lang.String,java.lang.String,java.lang.Number)>(r1, r2, $r5);	return b0
;block_num 3